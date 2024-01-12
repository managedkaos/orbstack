NAME    := $(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
ARCH    := amd64
OS      := ubuntu
VERSION := jammy
TARGETS := docker node postgresql zabbix init

help:
	@grep -E "^orb" README.md

server:
	-orb create --user-data ubuntu/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

lab:
	-orb create --user-data ubuntu/apache-https-lab.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh
