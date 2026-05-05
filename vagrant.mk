.PHONY: dev-up dev-halt dev-reload dev-destroy dev-ssh dev-status dev-provision

dev-up:
	vagrant up

dev-halt:
	vagrant halt

dev-reload:
	vagrant reload

dev-destroy:
	vagrant destroy -f

dev-ssh:
	vagrant ssh

dev-status:
	vagrant status

dev-provision:
	vagrant provision
