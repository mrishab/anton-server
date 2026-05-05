.PHONY: deploy dry-run ping dev-deploy dev-dry-run dev-ping

INVENTORY := ansible/inventory
PLAYBOOK := ansible/playbook.yml
ANSIBLE := ansible-playbook -i $(INVENTORY)

# Add -K to prompt for sudo password
ANSIBLE_FLAGS := --ask-become-pass

# Default apps and limits
ANSIBLE_VARS := $(if $(APPS),-e "apps=$(APPS)",)
ANSIBLE_LIMIT := $(if $(LIMIT),--limit $(LIMIT),)

ping:
	ansible all -i $(INVENTORY) -m ping

dev-ping:
	ansible anton-dev -i $(INVENTORY) -m ping

dry-run:
	$(ANSIBLE) $(PLAYBOOK) $(ANSIBLE_FLAGS) $(ANSIBLE_LIMIT) $(ANSIBLE_VARS) --check --diff

deploy:
	$(ANSIBLE) $(PLAYBOOK) $(ANSIBLE_FLAGS) $(ANSIBLE_LIMIT) $(ANSIBLE_VARS)
