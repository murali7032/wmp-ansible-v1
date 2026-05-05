# wmp-ansible-v1

Ansible playbooks for Wealth Management Platform (WMP) components.

## Prerequisites

- [GNU Make](https://www.gnu.org/software/make/) (`make`)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (`ansible-playbook` on your `PATH`)
- [Git](https://git-scm.com/) (the Makefile runs `git pull` before each run)
- Network access from your machine to the target EC2 hosts (`*-dev.devmonkey.online`)

## Makefile behavior

The `default` target does two things in order:

1. `**git pull**` — updates the current branch from the configured remote.
2. `**ansible-playbook**` — runs the playbook named `**${COMPONENT}.yml**` against inventory host `**${COMPONENT}-dev.devmonkey.online**`, with:
  - `ansible_user=ec2-user`
  - `ansible_password=DevOps321` (as defined in the Makefile)

You **must** set the `**COMPONENT`** environment variable so it matches a playbook file **without** the `.yml` suffix.

Playbooks in this directory:


| Set `COMPONENT` to  | Playbook file           |
| ------------------- | ----------------------- |
| `postgresql`        | `postgresql.yml`        |
| `auth-service`      | `auth-service.yml`      |
| `portfolio-service` | `portfolio-service.yml` |
| `frontend`          | `frontend.yml`          |
| `analytics-service` | `analytics-service.yml` |


The implied inventory host is then `postgresql-dev.devmonkey.online`, `auth-service-dev.devmonkey.online`, and so on.

## How to run it

Change into this directory first:

```bash
cd Ansible/wmp-ansible-v1
```

### Linux / macOS (bash)

```bash
export COMPONENT=frontend
make
```

Examples for other services:

```bash
export COMPONENT=frontend && make
export COMPONENT=postgresql && make
export COMPONENT=auth-service && make
export COMPONENT=portfolio-service && make
export COMPONENT=analytics-service && make
```

### Windows (PowerShell)

```powershell
cd Ansible\wmp-ansible-v1
$env:COMPONENT = "frontend"
make
```

### Windows (Command Prompt)

```cmd
cd Ansible\wmp-ansible-v1
set COMPONENT=frontend
make
```

### One line (bash)

```bash
cd Ansible/wmp-ansible-v1 && COMPONENT=frontend make
```

If `COMPONENT` is unset, Make will still run but Ansible will look for a file named `.yml`, which will fail—always export or set `COMPONENT` first.

## Notes

- **Inventory**: The Makefile uses a one-host “comma inventory” (`host,`) so Ansible treats that hostname as the target group.
- **Secrets**: The SSH password is embedded in the Makefile for lab use. Prefer Ansible Vault, `ansible_ssh_private_key_file`, or `ssh-agent` for real environments.
- **Without Make**: Equivalent to what `make` runs after `git pull`:
  ```bash
  ansible-playbook -i "${COMPONENT}-dev.devmonkey.online," \
    -e ansible_user=ec2-user \
    -e ansible_password=DevOps321 \
    "${COMPONENT}.yml"
  ```

