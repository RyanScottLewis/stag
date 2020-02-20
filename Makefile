PROJECT_NAME  = stag
PROJECT_SRC   = src
PROJECT_BUILD = build

CR_SOURCES = $(shell find $(PROJECT_SRC) -name "*.cr")
CR_MAIN    = $(PROJECT_SRC)/main.cr
CR_BINARY  = $(PROJECT_BUILD)/$(PROJECT_NAME)

.PHONY: all build

all: build

build: $(CR_BINARY)

$(CR_BINARY): $(CR_MAIN) $(CR_SOURCES) | $(PROJECT_BUILD)/
	crystal build $< -o $@

$(PROJECT_BUILD)/:
	mkdir -p $@

