# Anton Server

Anton Server is an infrastructure-as-code repository for provisioning and managing a Linux-based server using **Ansible** and **Vagrant**. It sets up a secure, monitored, and Docker-ready environment with support for RAID storage, user management, and Nvidia drivers.

## Features

- **Automated Provisioning:** fully declarative setup using Ansible playbooks.
- **Local Development Environment:** pre-configured Vagrant setup using QEMU (`arm64`) to test playbooks locally before production deployment.
- **Security Hardened:**
  - **SSH:** Disables root login and password authentication; enforces public key authentication.
  - **Firewall (UFW):** Default deny incoming; explicitly allows SSH (22) and Node Exporter (9100).
  - **Intrusion Prevention:** Fail2Ban configured to protect SSH.
- **Monitoring:** Node Exporter installed and configured as a systemd service.
- **Container Ready:** Automatically installs Docker and Docker Compose plugin.
- **Storage Management:** Support for RAID 5 arrays (`mdadm`) and custom fstab mounts for external HDDs.
- **System Configuration:** Sets up required users (e.g., `mrishab`, `jaas`, `sarthak`) with appropriate groups (`sudo`, `docker`), SSH keys, and system-level sysctl limits.

## Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Make](https://www.gnu.org/software/make/)
- [Vagrant](https://developer.hashicorp.com/vagrant) (for local testing)
- Vagrant QEMU Plugin (`vagrant plugin install vagrant-qemu`)

## Usage

The project utilizes `Make` to simplify Ansible and Vagrant commands.

### Production Deployment

To deploy to all servers defined in the inventory:

```bash
# Run a dry-run to see what changes will be applied
make dry-run

# Execute the deployment (prompts for sudo password)
make deploy
```

You can target specific hosts using the `LIMIT` variable:

```bash
make deploy LIMIT=anton
```

### Local Development (anton-dev)

A Vagrant environment is provided to test the Ansible playbooks safely.

```bash
# Start the local Vagrant VM
make dev-up

# SSH into the Vagrant VM
make dev-ssh

# Check the status of the VM
make dev-status

# Run the Ansible playbook against the local dev VM
make dev-deploy

# Run a dry-run against the local dev VM
make dev-dry-run

# Destroy the local VM
make dev-destroy
```

### Additional Commands

- `make ping`: Pings all servers in the inventory.
- `make dev-ping`: Pings the local dev server.
- `make check-nvidia`: Runs `nvidia-smi` across the inventory.

## Configuration

Modify the files within `ansible/vars/` to adjust the configuration before deploying:
- `packages.yml`: Add or remove system-level apt packages.
- `security_config.yml`: Adjust SSH ports, users, UFW rules, and Fail2ban settings.
- `storage_config.yml`: Configure RAID arrays and fstab mounts.
- `system_config.yml`: Manage system users and sysctl parameters.
