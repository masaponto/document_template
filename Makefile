all: pdf

PDF_FILE := document.pdf
HTML_FILE := document.html

.PHONY: pdf html clean

pdf: *_*.md title.txt res/eisvogel.tex res/listing_setup.tex
	docker run --rm -t -i -v `pwd`:/workspace \
	masaponto/pandoc *_*.md -o $(PDF_FILE)  \
	--listings -H res/listing_setup.tex title.txt \
	-F pandoc-crossref  \
	--from markdown \
	--latex-engine=xelatex \
	--template res/eisvogel.tex \
	-V CJKmainfont=IPAexMincho \
	-V lang=en-US

html: *_*.md res/github_pandoc.css
	docker run --rm -t -i -v `pwd`:/workspace \
	masaponto/pandoc *_*.md -o $(HTML_FILE)  \
	-s --self-contained -t html5 -c res/github_pandoc.css \
	-F pandoc-crossref

clean:
	rm -f $(PDF_FILE) $(HTML_FILE)
