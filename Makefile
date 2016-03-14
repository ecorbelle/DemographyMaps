## Documento maestro para a visualización da evolución da poboación en Galicia
## Eduardo Corbelle
## Baseado no script orixinal de abril de 2013 e modificado en xullo de 2015 e marzo de 2016

R_OPTS=--vanilla

all: Diapos.pdf Screenshot.png

Diapos.pdf: Diapos.tex Figuras/mapa1.pdf
	# Crear as diapositivas de exemplo
	pdflatex Diapos.tex
	pdflatex Diapos.tex
	rm *.aux *.log *.nav *.out *.snm *.toc

Screenshot.png: Figuras/mapa50.pdf
	convert -density 200 Figuras/mapa50.pdf Screenshot.png

Figuras/mapa1.pdf: Scripts/FuncionsMapas.R Scripts/Figuras.R DatosProc/CensoInterpolado.csv
	rm -f Figuras/*.pdf 
	R CMD BATCH $(R_OPTS) Scripts/Figuras.R Scripts/Figuras.Rout

DatosProc/CensoInterpolado.csv: Scripts/Interpolacion.R DatosProc/CensoConcellos.csv
	R CMD BATCH $(R_OPTS) Scripts/Interpolacion.R Scripts/Interpolacion.Rout

DatosProc/CensoConcellos.csv: Scripts/EntradaDatos.R DatosOrix/*.txt
	R CMD BATCH $(R_OPTS) Scripts/EntradaDatos.R Scripts/EntradaDatos.Rout
