require(maptools)
require(rgdal)
require(classInt)

# Mapa de municipios
mapa.municipios<-readOGR("./Carto","DATOS_S_CONCELLOS_simplif500m")
mapa.municipios@data<-cbind(mapa.municipios@data,
                            codigoine=mapa.municipios@data$CDPROVI*1000+mapa.municipios@data$CDMUNI)

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
anos <- substr(colnames(poboacion)[3:14],start=2,stop=5)

# Función "mapa"
mapa <- function(x) {
  
  png(filename=paste("./Figuras/mapa",x,".png",sep=""),# ou png(filename=paste("mapa",anos[x],".png",sep="")
      width=800, height=600,
      units="px",
      bg="transparent")
  
  orde<-match(mapa.municipios@data$codigoine,
              poboacion$codigoine)
  
  par(mar=c(5,1,4,1)+.1)
  clases <- clases.f(densidade.log[orde,x])
  clases.cor <- findColours( clases, cores )
  tamaño <- sqrt(poboacion2[orde,x] / 1500 )
  
  plot(mapa.municipios, col="white", lwd=.5, border="grey")
  title(main=anos[x],
        sub="(Elab. a partir de datos censais)",cex.main=2,cex.sub=1.5)
  points(long, lat,
         pch=19, 
         bg=clases.cor,
         col=clases.cor,
         cex=tamaño)
  
  legend(395000,4800000,
         legend=c("[0,10)","[10,20)","[20,50)","[50,150)","[150,400)","[400,1000)","[1000,3000)",">3000"),
         fill=attr(clases.cor,"palette"),
         bty="n",title="hab / km²",
         cex=1.5)
  
  points(410000,4680000,pch=19,bg="grey",cex=1)
  text(425000,4680000,"1500 hab",pos=4,cex=1.5)
  
  points(410000,4665000,pch=19,bg="grey",cex=5.16)
  text(425000,4665000,"40000 hab",pos=4,cex=1.5)
  
  points(410000,4640000,pch=19,bg="grey",cex=8.16)
  text(425000,4640000,"100000 hab",pos=4,cex=1.5)
  
  dev.off()
}