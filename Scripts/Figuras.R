require(RColorBrewer)


cores <- brewer.pal(9,"Oranges")


# Figuras en png
for(x in 1:112) {
  png(filename=paste("./Figuras/FigurasPNG1/mapa",x,".png",sep=""),
      width=800, height=600,
      units="px",
      bg="transparent")
  mapa(x, liña=.5)
  dev.off()
}

# Figuras en png 001 a 112
for(x in 1:112) {
  png(filename=paste("./Figuras/FigurasPNG2/mapa",
                     formatC(x, width=3, format="d", flag="0"),
                     ".png",sep=""),
      width=800, height=600,
      units="px",
      bg="white")
  mapa(x, liña=.5)
  dev.off()
}


# Figuras en pdf
for(x in 1:112) {
  pdf(file=paste("./Figuras/FigurasPDF/mapa",x,".pdf",sep=""),
      width=12, height=12*2/3)
  mapa(x, liña=.1)
  dev.off()  
}
