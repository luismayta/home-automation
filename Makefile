#
# See ./CONTRIBUTING.rst
#

# Command variables
# Go env variables
GOPATH	= $(shell go env GOPATH)
GOBIN	= $(GOPATH)/bin

export GO111MODULE := on
export GO_VERSION=$(shell go version)
export BUILT_BY=$(shell whoami)-$(shell hostname)

PKG := github.com/luismayta/homeautomation
VERSION := $(shell git describe --tags --always --long --dirty)
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
BUILD_DATE := $(shell date +%Y%m%d-%H:%M:%S)

GOLANGCI_VERSION ?= 1.27.0

OS := $(shell uname)

.PHONY: help
.DEFAULT_GOAL := help

HAS_PIP := $(shell command -v pip;)
HAS_PIPENV := $(shell command -v pipenv;)

ifdef HAS_PIPENV
	PIPENV_RUN:=pipenv run
	PIPENV_INSTALL:=pipenv install
else
	PIPENV_RUN:=
	PIPENV_INSTALL:=
endif

TEAM := luismayta
REPOSITORY_DOMAIN:=github.com
REPOSITORY_OWNER:=${TEAM}
AWS_VAULT ?= ${TEAM}
KEYBASE_OWNER ?= ${TEAM}
KEYBASE_PATH_TEAM_NAME ?=private
PROJECT := homeautomation
PROJECT_PORT := 3000

AWS_PROFILE_NAME ?=

# Compilation variables
PROJECT_BUILD_SRCS = $(shell find ./ -type f -name '*.go' | grep -v '/vendor/' | sort | uniq)

PYTHON_VERSION=3.8.0
NODE_VERSION=12.14.1
TERRAFORM_VERSION=0.13.1
PYENV_NAME="${PROJECT}"

# Configuration.
SHELL ?=/bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=🍺️
MESSAGE_HAPPY:="Done! ${MESSAGE}, Now Happy Hacking"
SOURCE_DIR=$(ROOT_DIR)/
PROVISION_DIR:=$(ROOT_DIR)/provision
FILE_README:=$(ROOT_DIR)/README.rst
KEYBASE_VOLUME_PATH ?= /Keybase
KEYBASE_TEAM_PATH ?=${KEYBASE_VOLUME_PATH}/${KEYBASE_PATH_TEAM_NAME}/${KEYBASE_OWNER}
KEYBASE_PROJECT_PATH ?= ${KEYBASE_TEAM_PATH}/${REPOSITORY_DOMAIN}/${REPOSITORY_OWNER}/${PROJECT}

AWS_PATH_DEPLOY:=./dist
YARN_PATH_PUBLIC:=${AWS_PATH_DEPLOY}

terragrunt:=terragrunt

include provision/make/*.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    environment               create environment with pyenv'
	@echo '    setup                     install requirements'
	@echo ''
	@make ansible.help
	@make alias.help
	@make app.help
	@make docs.help
	@make test.help
	@make keybase.help
	@make ngrok.help
	@make utils.help
	@make python.help
	@make yarn.help

setup:
	@echo "=====> install packages..."
	make python.setup
	make python.precommit
	make yarn.setup
	@cp -rf provision/git/hooks/prepare-commit-msg .git/hooks/
	@[ -e ".env" ] || cp -rf .env.example .env
	make keybase.setup
	@echo ${MESSAGE_HAPPY}

environment:
	@echo "=====> loading virtualenv ${PYENV_NAME}..."
	make python.environment
	make keybase.environment
	@echo ${MESSAGE_HAPPY}

.PHONY: clean
clean:
	@rm -f ${PROJECT}
	@rm -f ./dist.zip
	@rm -fr ./vendor
	@rm -f /tmp/${PROJECT}

# Show to-do items per file.
todo:
	@grep \
		--exclude-dir=vendor \
		--exclude-dir=node_modules \
		--exclude-dir=bin \
		--exclude=Makefile \
		--text \
		--color \
		-nRo -E ' TODO:.*|SkipNow|FIXMEE:.*' .
.PHONY: todo
