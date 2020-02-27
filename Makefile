PROJECT_NAME  = stag
PROJECT_SRC   = src
PROJECT_BUILD = build

CR_SOURCES        = $(shell find $(PROJECT_SRC) -name "*.cr")
CR_MAIN           = $(PROJECT_SRC)/main.cr
CR_BINARY_DEVELOP = $(PROJECT_BUILD)/$(PROJECT_NAME)-dev
CR_BINARY_RELEASE = $(PROJECT_BUILD)/$(PROJECT_NAME)

.PHONY: all build

all: build

build: $(CR_BINARY_RELEASE)

dev: $(CR_BINARY_DEVELOP)

$(CR_BINARY_DEVELOP): $(CR_MAIN) $(CR_SOURCES) | $(PROJECT_BUILD)/
	crystal build $< -o $@ --error-trace

$(CR_BINARY_RELEASE): $(CR_MAIN) $(CR_SOURCES) | $(PROJECT_BUILD)/
	crystal build $< -o $@ --release

$(PROJECT_BUILD)/:
	mkdir -p $@

