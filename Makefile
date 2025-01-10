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
	orb create --user-data ubuntu/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

server-no-init:
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)

jupyter-hub:
	orb create --user-data ubuntu/jupyter-hub.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

lab:
	orb create --user-data ubuntu/apache-https-lab.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh
