.PHONY: deploy dry-run ping dev-deploy dev-dry-run dev-ping

PLAYBOOK := ansible/playbook.yml
ANSIBLE := ansible-playbook

# Add -K to prompt for sudo password
ANSIBLE_FLAGS := --ask-become-pass

# Default target and architecture
TARGET ?= anton

# Default apps and limits
ANSIBLE_VARS := -e "@ansible/vars/targets/$(TARGET).yml" $(if $(APPS),-e "apps=$(APPS)",)
ANSIBLE_LIMIT := $(if $(LIMIT),--limit $(LIMIT),)

ping:
	ansible all -m ping

dev-ping:
	ansible anton-dev -m ping

dry-run:
	$(ANSIBLE) $(PLAYBOOK) $(ANSIBLE_FLAGS) $(ANSIBLE_LIMIT) $(ANSIBLE_VARS) --check --diff

deploy:
	$(ANSIBLE) $(PLAYBOOK) $(ANSIBLE_FLAGS) $(ANSIBLE_LIMIT) $(ANSIBLE_VARS)
