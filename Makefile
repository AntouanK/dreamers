# A simple Makefile for your static asset compilation
#
## Usage
#
#   $ make            # compile files that need compiling
#   $ make clean all  # remove target files and recompile from scratch
#


# Variables
SRC=./src
DIST=./dist
ELM_URL='https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz'
ELM_BINARIES=./elm-binaries
ELM=$(ELM_BINARIES)/elm

# Targets
#
# The format goes:
#
#   target: list of dependencies
#     commands to build target
#
# If something isn't re-compiling double-check the changed file is in the
# target's dependencies list.

# Phony targets - these are for when the target-side of a definition
# (such as "all" below) isn't a file but instead a just label. Declaring
# it as phony ensures that it always run, even if a file by the same name
# exists.
.PHONY : build dist markup script clean elm-binaries

#------------------------------------------------------------------ build
# Compile the final targets
build: dist markup images stylesheet  script compile-elm

dist:
	mkdir -p $(DIST)

#------------------------------------------------------------------ clean
# Destroy the final targets
clean:
	rm -rv $(DIST)/*
	rm -rv $(ELM_BINARIES)/*

#------------------------------------------------------------------ elm binary
elm-binary: $(ELM_BINARIES)/elm

$(ELM_BINARIES)/elm:
	curl -L -o elm.gz $(ELM_URL)
	gunzip elm.gz
	mkdir -p $(ELM_BINARIES)
	mv -v elm $(ELM_BINARIES)/elm
	chmod +x $(ELM_BINARIES)/elm

#------------------------------------------------------------------ markup
markup: $(shell find $(SRC)/markup/*)
	cp -rv $(SRC)/markup/* $(DIST)/

#------------------------------------------------------------------ markup
images: $(shell find $(SRC)/images/*)
	mkdir -p $(DIST)/images
	cp -rv $(SRC)/images/* $(DIST)/images/

#------------------------------------------------------------------ script
#
script: $(shell find $(SRC)/script/*)
	mkdir -p $(DIST)/script
	cp -rv $(SRC)/script/* $(DIST)/script/

#------------------------------------------------------------------ stylesheet
# css files copied here
stylesheet: $(DIST)/stylesheet $(shell find $(SRC)/stylesheet/*)
	cp -rv $(SRC)/stylesheet/* $(DIST)/stylesheet/

$(DIST)/stylesheet:
	mkdir -p $(DIST)/stylesheet

#------------------------------------------------------------------ elm compilation
compile-elm: $(shell find $(SRC)/elm)
	elm make $(SRC)/elm/Main.elm --output=$(DIST)/script/elm-main.js

#------------------------------------------------------------------ serve
serve: elm-binary
	@echo 'Your site should be at http://localhost:8000/dist/index.html'
	$(ELM) reactor
