library(classInt)

# Cores
clases.f <- function(x) {
  classIntervals(x,
                 9,
                 style="fixed",
                 fixedBreaks=log(c(0.1,10,20,50,150,400,1000,3000,9000)),
                 na.rm=TRUE)
}

# Coordenadas dos concellos
long<-coordinates(mapa.municipios)[,1]
lat<-coordinates(mapa.municipios)[,2]


# Variables
anos <- 1900:2011 #anos <- substr(colnames(poboacion)[3:14],start=2,stop=5)

# Función "mapa"
mapa <- function(x, liña) {
  
  orde = match(mapa.municipios@data$codigoine,
               concellos$codigoine)
  layout(matrix(c(2,1,1,1,1,1,1,1,1), 3, 3, byrow=TRUE))
    
  # Primeira cuadrícula: mapa
  par(mar=c(5,5,4,0))
  clases = clases.f(densidade.log[orde,x])
  clases.cor = findColours( clases, cores )
  tamaño = sqrt(CensoInterp[orde,x] / 1500 )
  
  plot(mapa.municipios,
       xlim=c(360000, 690000),
       col="white", lwd=liña, border="grey50")
  title(main=anos[x],
        #sub="(Elab. a partir do Censo de Poboación, INE)",
        cex.main=2,cex.sub=1.5)
  
  nova.orde = order(tamaño, decreasing=TRUE)
  points(long[nova.orde], lat[nova.orde],
         pch=19, 
         bg=clases.cor[nova.orde],
         col=clases.cor[nova.orde],
         cex=tamaño[nova.orde])
  
  legend(350000,4760000,,
         legend=c("[0, 10)","[10, 20)","[20, 50)","[50, 150)","[150, 400)","[400, 1 000)","[1 000, 3 000)",">3 000"),
         fill=attr(clases.cor,"palette"),
         bty="n",title="Densidade (hab / km²)",
         cex=1.5)

  points(360000,4675000,pch=19,bg="grey",cex=1)
  text(360000+10000,4675000,"   1 500 hab",pos=4,cex=1.5)
  
  points(360000,4660000,pch=19,bg="grey",cex=5.16)
  text(360000+10000,4660000," 40 000 hab",pos=4,cex=1.5)
  
  points(360000,4645000,pch=19,bg="grey",cex=8.16)
  text(360000+10000,4645000,"100 000 hab",pos=4,cex=1.5)
  
  # Segunda cuadrícula: gráfica de poboación total
  par(mar=c(1,3,3,1))
  plot(anos[1:x], pob.total[1:x]/1000000, 
       col=cores[9], type="l", lwd=2,
       xlim=c(1900,2020), ylim=c(0,3),
       xlab="", ylab="", main="Poboación total (millóns)",
       las=1, bty="n",
       cex.axis=1.5)
}
