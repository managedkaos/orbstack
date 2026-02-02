ARCH     := amd64
OS       := ubuntu
VERSION  := noble
PACKAGES := node postgresql default aws-sam-cli docker github-cli starship


# Dynamically calculate NAME based on the target
define set_name
  NAME := $1-$(shell date +%A-%F.%s | tr '[:upper:]' '[:lower:]')
endef

help:
	@cat .help
	@echo "\t$(PACKAGES)"
	@echo "\trun make NAME=SERVER_NAME PACKAGE_NAME"

list-machines:
	orb list

server:
	$(eval $(call set_name,$(@)))
	orb create --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	orb -m $(NAME) sudo ./ubuntu/install-default.sh
	@echo "ssh $(NAME)@orb"

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
	orb create --user-data ubuntu/_Archive/init.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

jupyter-hub:
	orb create --user-data ubuntu/_Archive/jupyter-hub.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

apache:
	orb create --user-data ubuntu/_Archive/apache.yml --arch $(ARCH) $(OS):$(VERSION) $(NAME)
	@echo "ssh $(NAME)@orb"

list-distros:
	@./scripts/scrape-distros.py

list-packages:
	@echo "$(PACKAGES)"

$(PACKAGES):
	@echo "### Installing $(@)"
	orb -m $(NAME) sudo ./$(OS)/install-$(@).sh

.PHONY: help list server ubuntu rocky jupyter-hub apache $(PACKAGES)
