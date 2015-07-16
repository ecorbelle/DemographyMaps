# Crear gif con 3 fps (1/0.33)
system("convert -delay 33 -loop 0 ./Figuras/FigurasPNG2/mapa*.png ./Figuras/Gif/animacion.gif")
# Optimizar o gif
system("gifsicle -O3 ./Figuras/Gif/animacion.gif > ./Figuras/Gif/animacion_optim.gif")
# Extraer png do gif optimizado
system("convert -page 800x600 ./Figuras/Gif/animacion_optim.gif -matte -background none -layers coalesce -quality 90 ./Figuras/FigurasOptim/mapa.png > ./Figuras/FigurasOptim/timeline.txt")
#system("sh ./Scripts/ungif.sh ./Figuras/Gif/animacion_optim.gif ./Figuras/FigurasOptim/mapa.png > ./Figuras/FigurasOptim/timeline.txt")

