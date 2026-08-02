
# Ansible Installation & Configuration on Ubuntu 24.04 LTS

## Introduction to Ansible

Ansible is an open-source automation tool used for configuration management, application deployment, software provisioning, and server orchestration. It is agentless, which means it communicates with managed servers over SSH without requiring any agent installation.

In this guide, we will install Ansible on Ubuntu 24.04 LTS, configure the controller machine, establish passwordless SSH connectivity with managed nodes, execute ad-hoc commands, and run our first Ansible playbook.

---

# Lab Architecture

* 1 Ansible Controller (Ubuntu 24.04 LTS)
* 1 or More Managed Nodes (Ubuntu 24.04 LTS)
* Passwordless SSH Connectivity between Controller and Managed Nodes

---

# Installing Ansible

Update the package repository and install Ansible using the following commands.

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install ansible -y
ansible --version
```

If the `/etc/ansible` directory is not available, create it manually.

```bash
sudo mkdir -p /etc/ansible
```

---

# Configuring Ansible

Edit the Ansible configuration file.

```bash
sudo nano /etc/ansible/ansible.cfg
```

Add the following configuration.

```ini
[defaults]
inventory=/etc/ansible/hosts
host_key_checking=False
remote_user=client
forks=5
timeout=30
```

> Replace `client` with your Linux username if required.

---

# Configuring the Inventory File

Create or edit the inventory file.

```bash
sudo nano /etc/ansible/hosts
```

Single managed node:

```ini
[client]
35.xxx.xxx.xxx ansible_user=client
```

Multiple managed nodes:

```ini
[webservers]
10.10.0.4 ansible_user=client
10.10.0.5 ansible_user=client
```

---

# Establishing Passwordless SSH Connectivity

Generate an SSH key on the Ansible Controller.

```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub
```

On the managed node, create the SSH directory if required.

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
```

Paste the public key into the `authorized_keys` file and save it.

Set the required permissions.

```bash
chmod 600 ~/.ssh/authorized_keys
```

Verify SSH connectivity.

```bash
ssh client@35.xxx.xxx.xxx
```

---

# Testing Ansible Connectivity

Run the following commands to verify communication with the managed nodes.

```bash
ansible all -m ping
ansible all -a "hostname"
ansible all -a "df -h"
ansible all -a "free -h"
ansible all -a "uptime"
```

---

# Configuring Passwordless Sudo

To execute playbooks with `become: yes`, configure passwordless sudo on each managed node.

```bash
sudo visudo
```

Add the following entry.

```text
client ALL=(ALL) NOPASSWD:ALL
```

Verify the configuration.

```bash
sudo -l
```

---

# Running Your First Ansible Playbook

Create a file named `playbook.yaml`.

```yaml
---
- name: Install Apache
  hosts: all
  become: yes

  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present
        update_cache: yes
```

Execute the playbook.

```bash
ansible-playbook playbook.yaml
```

---

# Common Ansible Ad-hoc Commands

```bash
ansible all -m ping
ansible all -m setup
ansible all -a "hostname"
ansible all -a "whoami"
ansible all -a "date"
ansible all -a "df -h"
ansible all -a "free -h"
ansible all -a "uptime"
ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"
ansible all -m file -a "path=/tmp/testfile state=touch"
ansible all -m service -a "name=apache2 state=started" --become
ansible all -m service -a "name=apache2 state=stopped" --become
ansible all -m apt -a "name=apache2 state=latest" --become
```

---

# Conclusion

You have successfully installed and configured Ansible on Ubuntu 24.04 LTS, established passwordless SSH connectivity with managed nodes, configured passwordless sudo, executed ad-hoc commands, and deployed your first Ansible playbook. This setup provides the foundation for automating Linux server administration using Ansible.
