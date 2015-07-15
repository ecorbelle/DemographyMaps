# Datos INE (censos de poboación, 1900 - 1991)
censos <- rbind(
  read.table("Datos/A coruña.txt", header=TRUE, sep=";", na.string=".."),
  read.table("Datos/Lugo.txt", header=TRUE, sep=";", na.string=".."),
  read.table("Datos/Ourense.txt", header=TRUE, sep=";", na.string=".."),
  read.table("Datos/Pontevedra.txt", header=TRUE, sep=";", na.string=".."))

codigoine <- as.integer(substr( censos$concello,start=1,stop=5))

censos <- cbind( codigoine, censos)

# Datos IGE (censos de poboación 2001, 2011)
censos2 <- read.table("Datos/Galicia.txt",header=TRUE,sep=";")[,c(1,2,4,5)]

# Unión dos dous
poboacion <- merge(censos[,c(1,3:12)], censos2, by="codigoine", all=TRUE)
poboacion <- data.frame(poboacion[,c(1,12,11:2,13,14)])

# Superficie
superficie<-read.table("Datos/superficie.txt",
                       header=TRUE,
                       sep=";",
                       dec=",",
                       na.string="-")[,c(1,3)]

# Nova unión
poboacion <- merge(poboacion, superficie, by="codigoine")

# Limpeza do espazo de traballo
rm(censos, censos2, codigoine)

# Transformación dos datos
poboacion.log <- log( poboacion[,3:14] )
poboacion2 <- poboacion[,3:14]

# Densidade de poboacion
densidade <- poboacion[,3:14] / poboacion$sup1996
densidade.log <- log(densidade)