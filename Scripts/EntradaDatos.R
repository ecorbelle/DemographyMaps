# Script inicial para preparar os datos censais procedentes do INE ou IGE
# Eduardo Corbelle, xullo de 2015


# Datos INE (censos de poboación, 1900 - 1991)
censos <- rbind(
  read.table("DatosOrix/A coruña.txt", header=TRUE, sep=";", na.string=".."),
  read.table("DatosOrix/Lugo.txt", header=TRUE, sep=";", na.string=".."),
  read.table("DatosOrix/Ourense.txt", header=TRUE, sep=";", na.string=".."),
  read.table("DatosOrix/Pontevedra.txt", header=TRUE, sep=";", na.string=".."))

codigoine <- as.integer(substr( censos$concello,start=1,stop=5))

censos <- cbind(codigoine, censos)

# Datos IGE (censos de poboación 2001, 2011)
censos2 <- read.table("DatosOrix/Galicia.txt",header=TRUE,sep=";")[,c(1,2,4,5)]

# Unión dos dous
concellos <- merge(censos[,c(1,3:12)], censos2, by="codigoine", all=TRUE)
concellos <- data.frame(concellos[,c(1,12,11:2,13,14)])

# Superficie
superficie<-read.table("DatosOrix/superficie.txt",
                       header=TRUE,
                       sep=";",
                       dec=",",
                       na.string="-")[,c(1,3)]

# Nova unión
concellos <- merge(concellos, superficie, by="codigoine")

# Exportamos os valores a unha única táboa
write.csv(concellos, "DatosProc/CensoConcellos.csv", row.names=FALSE)