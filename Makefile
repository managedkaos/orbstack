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
	@echo "ssh $(NAME)@orb"

ubuntu:
	orb create --user-data ubuntu/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

rocky:
	orb create --arch $(ARCH) rocky:9 $(NAME)
	orb -m $(NAME) sudo ./rocky/init.sh
	@echo "ssh $(NAME)@orb"

jupyter-hub:
	orb create --user-data ubuntu/jupyter-hub.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

apache:
	orb create --user-data ubuntu/apache.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh

.PHONY: help list server ubuntu rocky jupyter-hub apache $(TARGETS)
