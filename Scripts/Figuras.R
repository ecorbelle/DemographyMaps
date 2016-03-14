## Script para xerar as figuras en pdf
## Eduardo Corbelle, xullo de 2015 (modificado en marzo de 2016)

library(RColorBrewer)
library(rgdal)
library(maptools)

## Escoller a gama de cores
cores <- brewer.pal(9,"Blues")

## Cargar datos de partida
pob.total     <- scan("DatosProc//PobTotal.csv", skip=1)
CensoInterp   <- read.csv("DatosProc/CensoInterpolado.csv")
densidade.log <- read.csv("DatosProc/DensidadeLog.csv")
concellos     <- read.csv("DatosProc/CensoConcellos.csv")
mapa.municipios<-readOGR("DatosOrix/Carto","DATOS_S_CONCELLOS_simplif500m")
mapa.municipios@data<-cbind(mapa.municipios@data,
                            codigoine=mapa.municipios@data$CDPROVI*1000+mapa.municipios$CDMUNI)
                             

## Chamar as funcións para crear mapas
source("Scripts//FuncionsMapas.R")



# Figuras en pdf
for(x in 1:112) {
  pdf(file=paste("./Figuras/mapa",x,".pdf",sep=""),
      width=12, height=12*2/3)
  mapa(x, liña=.1)
  dev.off()  
}
