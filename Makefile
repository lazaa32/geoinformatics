FILES=$(shell ls *.tex | sed s/.tex/.pdf/)
VERSION=$(shell awk '/ProvidesClass/{print $$2}' gifce.cls | sed s/v//)

all: $(FILES)

%.pdf : %.tex gifce.cls gifce.bib Makefile
	pdflatex $*
	biber    $*
	pdflatex $*


zip:
	@make
	@make -C lyx
	@make -C lyx clean
	@make -C ../software/metadata2tex distclean
	@rm -f    gifce-template-$(VERSION) gifce-template-$(VERSION).zip
	@ln -sf . gifce-template-$(VERSION)
	@ln -sf ../software/metadata2tex
	@zip -r   gifce-template-$(VERSION).zip \
			gifce-template-$(VERSION)/Makefile \
			gifce-template-$(VERSION)/gifce.cls \
			gifce-template-$(VERSION)/*.bib \
			gifce-template-$(VERSION)/*.tex \
			gifce-template-$(VERSION)/*.pdf \
			gifce-template-$(VERSION)/img*.png \
			gifce-template-$(VERSION)/metadata2tex/* \
			gifce-template-$(VERSION)/lyx/Makefile \
			gifce-template-$(VERSION)/lyx/*.lyx \
			gifce-template-$(VERSION)/lyx/*.png \
			gifce-template-$(VERSION)/lyx/*.bib \
			gifce-template-$(VERSION)/lyx/*.tex \
			gifce-template-$(VERSION)/lyx/*.pdf
	@rm -f gifce-template-$(VERSION)
	@rm -f metadata2tex
	@make clean

clean:
	rm -f *~ *.log *.out *.aux *.bbl *.bcf *.blg *.run.xml

distclean:
	make -C lyx clean
	rm -f $(FILES)
	make clean
