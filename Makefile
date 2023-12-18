NAME    := $(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
ARCH    := amd64
OS      := ubuntu
VERSION := jammy
TARGETS := docker node

help:
	@grep -E "^orb" README.md

server:
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	orb -m $(NAME) sudo ./$(OS)/init.sh

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh
