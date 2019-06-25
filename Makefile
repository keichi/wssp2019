MAIN=src/main.tex
SOURCES=$(wildcard ./src/*.tex)
IMAGE_OBJS=$(wildcard ./img/*.obj)
IMAGES=$(IMAGE_OBJS:.obj=.eps)
REFERENCES=references.bib

.PHONY: all clean open watch

all: main.pdf

%.eps: %.obj
	tgif -color -print -eps $<

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(REFERENCES)
	latexmk -pdf $(MAIN)

clean:
	latexmk -C $(MAIN)

open: main.pdf
	latexmk -pdf -pv $(MAIN)

watch: main.pdf
	latexmk -pdf -pvc $(MAIN)

release: main.pdf
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dEmbedAllFonts=true -sOutputFile=wssp2019-$(shell date +"%m%d").pdf main.pdf
