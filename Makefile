NAME    := $(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
ARCH    := amd64
OS      := ubuntu
VERSION := oracular
TARGETS := docker node postgresql zabbix init

help:
	@grep -E "^orb" README.md

list:
	orb list

server:
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)

ubuntu:
	orb create --user-data ubuntu/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

rocky:
	orb create --arch $(ARCH) rocky:9 $(NAME)
	orb -m $(NAME) sudo ./rocky/init.sh

jupyter-hub:
	orb create --user-data ubuntu/jupyter-hub.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

apache:
	orb create --user-data ubuntu/apache.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh

.PHONY: help list server ubuntu rocky jupyter-hub apache $(TARGETS)
