# —— Inspired by ———————————————————————————————————————————————————————————————
# https://www.strangebuzz.com/en/snippets/the-perfect-makefile-for-symfony

# Setup ————————————————————————————————————————————————————————————————————————

# Parameters
SHELL         = bash
ME            = $(shell whoami)

PORT          = 8091
NUMPROC := $(shell grep -c ^processor /proc/cpuinfo)
# Only take half as many processors as available
NPROC := $(shell echo "$(NUMPROC)/2"|bc)
NPROC := 1

# Image
APP_NAME     = nabla-memo

# Executables: local only
# DOCKER        = docker

GIT_BRANCH = $$(git symbolic-ref --short HEAD)

# Misc
.DEFAULT_GOAL = fmt
.PHONY       =  # Not needed here, but you can put your all your targets to be sure
	            # there is no name conflict between your files and your targets.

## —— 🐝 The Strangebuzz Docker Makefile 🐝 ———————————————————————————————————

_welcome: ## Print a Welcome screen
	curl -s https://raw.githubusercontent.com/AlbanAndrieu/AlbanAndrieu/master/welcome.txt

.PHONY: help Makefile
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: help Makefile
%: Makefile

## —— All 🎵 ———————————————————————————————————————————————————————————————
.PHONY: all
all: fmt

## —— Formating 🧪🔗 ———————————————————————————————————————————————————————————————
.PHONY: fmt
fmt: ## Run formating
	@echo "=> Executing formating..."
	shfmt -i 2 -ci -w *.sh || true
