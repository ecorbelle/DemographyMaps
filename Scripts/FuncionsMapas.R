require(classInt)

# Cores
clases.f <- function(x) {
  classIntervals(x,
                 9,
                 style="fixed",
                 fixedBreaks=log(c(0.1,10,20,50,150,400,1000,3000,9000)))
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
  
  par(mar=c(5,1,4,1)+.1)
  clases = clases.f(densidade.log[orde,x])
  clases.cor = findColours( clases, cores )
  tamaño = sqrt(poboacion2[orde,x] / 1500 )
  
  plot(mapa.municipios, col="white", lwd=liña, border="grey50")
  title(main=anos[x],
        sub="(Elab. a partir do Censo de Poboación, INE)",cex.main=2,cex.sub=1.5)
  
  nova.orde = order(tamaño, decreasing=TRUE)
  points(long[nova.orde], lat[nova.orde],
         pch=19, 
         bg=clases.cor[nova.orde],
         col=clases.cor[nova.orde],
         cex=tamaño[nova.orde])
  
  legend(395000,4800000,
         legend=c("[0, 10)","[10, 20)","[20, 50)","[50, 150)","[150, 400)","[400, 1 000)","[1 000, 3 000)",">3 000"),
         fill=attr(clases.cor,"palette"),
         bty="n",title="hab / km²",
         cex=1.5)
  
  points(410000,4680000,pch=19,bg="grey",cex=1)
  text(425000,4680000,"   1 500 hab",pos=4,cex=1.5)
  
  points(410000,4665000,pch=19,bg="grey",cex=5.16)
  text(425000,4665000," 40 000 hab",pos=4,cex=1.5)
  
  points(410000,4640000,pch=19,bg="grey",cex=8.16)
  text(425000,4640000,"100 000 hab",pos=4,cex=1.5)
}