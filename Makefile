DIAGRAMS := $(wildcard diagrams/*.mmd)
ASSETS := $(DIAGRAMS:diagrams/%.mmd=assets/%.png)
SLIDES := $(wildcard src/*.md)
PDFS := $(SLIDES:src/%.md=output/%.pdf)
HTMLS := $(SLIDES:src/%.md=output/%.html)

all: $(ASSETS) $(PDFS) $(HTMLS)

assets/%.png: diagrams/%.mmd diagrams/mermaid.config.json
	mmdc -i $< -o $@ -b white -s 2 -c diagrams/mermaid.config.json

output/%.pdf: src/%.md $(ASSETS) | output
	marp $< --pdf --allow-local-files -o $@

output/%.html: src/%.md $(ASSETS) | output
	marp $< --html -o $@

output:
	mkdir -p output

clean:
	rm -f assets/*.png
	rm -rf output

.PHONY: all clean
