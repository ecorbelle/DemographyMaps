# Script para interpolar os datos censais decenais a valores anuais (interpolación lineal)
# Eduardo Corbelle, xullo de 2015

concellos <- read.csv("DatosProc/CensoConcellos.csv")

# Interpolación
pob.prov <- concellos[3:14] #taboa provisional
anos.ref <- c(seq(1900, 1970, 10),
              seq(1981, 2011, 10))

## Función de interpolación
fInterp <- function(ano) {
  if(is.element(ano, anos.ref)) {
    id=which(anos.ref==ano)
    return(pob.prov[,id])
  } else {
    i1 = which(anos.ref-ano<0)
    i2 = which( ((anos.ref-ano)[i1]) == max((anos.ref-ano)[i1]) ) # índice do ano inferior
    s1 = which(anos.ref-ano<11)
    s2 = which( ((anos.ref-ano)[s1]) == max((anos.ref-ano)[s1]) ) # índice do ano superior
    
    poboacion = (pob.prov[,s2]-pob.prov[,i2])*(ano-anos.ref[i2])/(anos.ref[s2]-anos.ref[i2])+pob.prov[,i2]
    return(poboacion)
  }
}

## creación dunha nova táboa
pob <- data.frame(1:315) # táboa baleira inicial
for(i in 1900:2011) {
  pob[,i-1899] <- fInterp(i)
}


# Transformación dos datos
# poboacion.log <- log( poboacion[,3:14] )
poboacion2 <- pob #poboacion2 <- poboacion[,3:14]
densidade <- pob / concellos$sup1996 #densidade <- poboacion[,3:14] / poboacion$sup1996
densidade.log <- log(densidade)

## Datos de poboación total
pob.total <- apply(pob, 2, sum, na.rm=TRUE)

# Escribimos os datos en csv
write.csv(poboacion2, "DatosProc/CensoInterpolado.csv", row.names=FALSE)
write.csv(densidade.log, "DatosProc/DensidadeLog.csv", row.names=FALSE)
write.csv(pob.total, "DatosProc/PobTotal.csv", row.names=FALSE)