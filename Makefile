ARCH    := amd64
OS      := ubuntu
VERSION := oracular
TARGETS := docker node postgresql zabbix init

# Dynamically calculate NAME based on the target
define set_name
  NAME := $1-$(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
endef

help:
	@grep -E "^orb" README.md

list:
	orb list

server:
	$(eval $(call set_name,$(@)))
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

ubuntu:
	$(eval $(call set_name,ubuntu))
	orb create --arch $(ARCH) ubuntu:$(VERSION) $(NAME)
	orb -m $(NAME) sudo ./ubuntu/init.sh
	@echo "ssh $(NAME)@orb"

rocky:
	$(eval $(call set_name,rocky))
	orb create --arch $(ARCH) rocky:9 $(NAME)
	orb -m $(NAME) sudo ./rocky/init.sh
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

$(TARGETS): server
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/$(@).sh

.PHONY: help list server ubuntu rocky jupyter-hub apache $(TARGETS)
