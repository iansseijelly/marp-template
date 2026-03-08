THEME ?= catppuccin-mocha
DIAGRAMS := $(wildcard diagrams/*.mmd)
ASSETS := $(DIAGRAMS:diagrams/%.mmd=assets/generated/%.png)
SLIDES := $(wildcard src/*.md)
PDFS := $(SLIDES:src/%.md=output/%.pdf)
HTMLS := $(SLIDES:src/%.md=output/%.html)
PPTXS := $(SLIDES:src/%.md=output/%.pptx)

all: $(ASSETS) $(PDFS) $(HTMLS) $(PPTXS)

assets/generated/%.png: diagrams/%.mmd diagrams/$(THEME).css
	mmdc -i $< -o $@ -b white -s 2 -C diagrams/$(THEME).css

output/%.pdf: src/%.md $(ASSETS) | output
	marp $< --pdf --allow-local-files --theme-set themes/ -o $@

output/%.html: src/%.md $(ASSETS) | output
	marp $< --html --theme-set themes/ -o $@

output/%.pptx: src/%.md $(ASSETS) | output
	marp $< --pptx --allow-local-files --theme-set themes/ -o $@

output:
	mkdir -p output

clean:
	rm -f assets/generated/*.png
	rm -rf output

.PHONY: all clean
