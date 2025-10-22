ARCH    := amd64
OS      := ubuntu
VERSION := noble
TARGETS := docker node postgresql zabbix init

# Dynamically calculate NAME based on the target
define set_name
  NAME := $1-$(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
endef

help:
	@echo "Usage: make server NAME=<name> [ARCH=<arch>] [OS=<os>] [VERSION=<version>]"
	@echo "Available architectures: amd64, arm64"
	@echo "Available operating systems: https://docs.orbstack.dev/machines/distros"

list-machines:
	orb list

default:
	$(eval $(call set_name,$(@)))
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	orb -m $(NAME) sudo ./ubuntu/init.sh
	@echo "ssh $(NAME)@orb"

server: default

ubuntu: default

demo:
	$(eval $(call set_name,$(@)))
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	orb -m $(NAME) sudo useradd -m -s /bin/bash demo
	@echo "ssh $(NAME)@orb"
	@echo "sudo visudo"
	@echo "demo ALL=(ALL) NOPASSWD: ALL"
	@echo "exit"
	@echo "ssh demo@$(NAME)@orb"

rocky:
	$(eval $(call set_name,rocky))
	orb create --arch $(ARCH) rocky:9 $(NAME)
	orb -m $(NAME) sudo ./rocky/init.sh
	orb -m $(NAME) sudo ./rocky/varnish-nginx.sh
	@echo "ssh $(NAME)@orb"

ubuntu-user-data:
	$(eval $(call set_name,ubuntu))
	orb create --user-data ubuntu/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

jupyter-hub:
	orb create --user-data ubuntu/jupyter-hub.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

apache:
	orb create --user-data ubuntu/apache.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

list-distros:
	@./scripts/scrape-distros.py

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh

.PHONY: help list server ubuntu rocky jupyter-hub apache $(TARGETS)
