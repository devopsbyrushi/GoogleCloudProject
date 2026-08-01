# 🚀 Ansible Setup on Google Cloud

> **Goal:** Install Ansible on a main/control server, configure
> passwordless SSH to a managed server, grant the `rushiawslabs` user
> passwordless sudo access, create an Ansible inventory, deploy Nginx
> using a YAML playbook, and verify the service state.

------------------------------------------------------------------------

## 🏗️ Lab Architecture

  -----------------------------------------------------------------------
  Server            Hostname          Role              User
  ----------------- ----------------- ----------------- -----------------
  Server 1          `ansibletest-1`   Ansible Control / `rushiawslabs`
                                      Main Server       

  Server 2          `ansibletest-2`   Managed / Target  `rushiawslabs`
                                      Server            
  -----------------------------------------------------------------------

``` text
┌──────────────────────────────┐
│       ansibletest-1          │
│   ANSIBLE CONTROL SERVER     │
│                              │
│   • Ansible installed        │
│   • inventory.ini            │
│   • nginx.yml                │
└──────────────┬───────────────┘
               │
               │ Passwordless SSH
               ▼
┌──────────────────────────────┐
│       ansibletest-2          │
│      MANAGED SERVER          │
│                              │
│   • Python                   │
│   • Nginx                    │
│   • Passwordless sudo        │
└──────────────────────────────┘
```

> **Note:** Replace `<SERVER-2-IP>` with the actual **internal IP
> address** of `ansibletest-2`.

------------------------------------------------------------------------

# 1️⃣ Install Ansible on the Main Server

### 📍 Run on: `ansibletest-1`

Update the package list:

``` bash
sudo apt update
```

Install Ansible:

``` bash
sudo apt install ansible -y
```

Verify the installation:

``` bash
ansible --version
```

> ✅ Ansible needs to be installed only on the **control/main server**.

------------------------------------------------------------------------

# 2️⃣ Generate an SSH Key

### 📍 Run on: `ansibletest-1`

Generate an SSH key pair:

``` bash
ssh-keygen -t rsa
```

Press **Enter** for all prompts:

``` text
Enter file in which to save the key: ENTER
Enter passphrase: ENTER
Enter same passphrase again: ENTER
```

Verify the generated keys:

``` bash
ls ~/.ssh/
```

You should see:

``` text
id_rsa
id_rsa.pub
```

------------------------------------------------------------------------

# 3️⃣ Copy the SSH Key to Server 2

### 📍 Run on: `ansibletest-1`

Copy the public key to the managed server:

``` bash
ssh-copy-id rushiawslabs@<SERVER-2-IP>
```

Example:

``` bash
ssh-copy-id rushiawslabs@10.128.0.3
```

> The first connection may ask for the Server 2 password or SSH
> confirmation.

------------------------------------------------------------------------

# 4️⃣ Test Passwordless SSH

### 📍 Run on: `ansibletest-1`

Connect to Server 2:

``` bash
ssh rushiawslabs@<SERVER-2-IP>
```

Example:

``` bash
ssh rushiawslabs@10.128.0.3
```

If the login succeeds without asking for a password:

``` text
Passwordless SSH = SUCCESS ✅
```

Your prompt should change from:

``` text
rushiawslabs@ansibletest-1:~$
```

to:

``` text
rushiawslabs@ansibletest-2:~$
```

------------------------------------------------------------------------

# 5️⃣ Give `rushiawslabs` Passwordless Sudo Permission

### 📍 Run on: `ansibletest-2`

Open the sudoers file:

``` bash
sudo vi /etc/sudoers
```

Add the following entry at the bottom:

``` text
rushiawslabs ALL=(ALL) NOPASSWD: ALL
```

Save and exit from `vi`:

``` text
ESC
:wq
ENTER
```

This allows Ansible to use `sudo` without prompting for a password.

Return to Server 1:

``` bash
exit
```

You should now be back on:

``` text
rushiawslabs@ansibletest-1:~$
```

------------------------------------------------------------------------

# 6️⃣ Create the Ansible Project Directory

### 📍 Run on: `ansibletest-1`

Create the project directory:

``` bash
mkdir -p ~/ansible-project
```

Enter the directory:

``` bash
cd ~/ansible-project
```

Verify:

``` bash
pwd
```

Expected path:

``` text
/home/rushiawslabs/ansible-project
```

------------------------------------------------------------------------

# 7️⃣ Create the Inventory File

### 📍 Run on: `ansibletest-1`

Create the inventory file:

``` bash
nano inventory.ini
```

Add:

``` ini
[webservers]
ansibletest-2 ansible_host=<SERVER-2-IP>

[webservers:vars]
ansible_user=rushiawslabs
ansible_python_interpreter=/usr/bin/python3
```

Example:

``` ini
[webservers]
ansibletest-2 ansible_host=10.128.0.3

[webservers:vars]
ansible_user=rushiawslabs
ansible_python_interpreter=/usr/bin/python3
```

Save the file:

``` text
CTRL + O
ENTER
CTRL + X
```

Verify:

``` bash
cat inventory.ini
```

------------------------------------------------------------------------

# 8️⃣ Test the Ansible Connection

### 📍 Run on: `ansibletest-1`

Run the Ansible ping module:

``` bash
ansible all -i inventory.ini -m ping
```

Expected result:

``` text
ansibletest-2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

> 🎯 `"ping": "pong"` confirms that Ansible can successfully communicate
> with the managed server.

------------------------------------------------------------------------

# 9️⃣ Test a Remote Command

### 📍 Run on: `ansibletest-1`

Check the hostname of the managed server:

``` bash
ansible all -i inventory.ini -a "hostname"
```

Expected:

``` text
ansibletest-2
```

You can also check uptime:

``` bash
ansible all -i inventory.ini -a "uptime"
```

These commands are entered on **Server 1** but executed remotely on
**Server 2**.

------------------------------------------------------------------------

# 🔟 Create an Nginx YAML Playbook

### 📍 Run on: `ansibletest-1`

Create the playbook:

``` bash
nano nginx.yml
```

Add:

``` yaml
---
- name: Install and Start Nginx
  hosts: webservers
  become: yes

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx Service
      service:
        name: nginx
        state: started
        enabled: yes
```

Save:

``` text
CTRL + O
ENTER
CTRL + X
```

------------------------------------------------------------------------

# 1️⃣1️⃣ Check the YAML Syntax

### 📍 Run on: `ansibletest-1`

Always check the playbook syntax before execution:

``` bash
ansible-playbook -i inventory.ini nginx.yml --syntax-check
```

Expected:

``` text
playbook: nginx.yml
```

> ✅ This confirms that the YAML/playbook syntax is valid.

------------------------------------------------------------------------

# 1️⃣2️⃣ Run the Nginx Playbook

### 📍 Run on: `ansibletest-1`

Execute:

``` bash
ansible-playbook -i inventory.ini nginx.yml
```

Expected recap:

``` text
PLAY RECAP
ansibletest-2 : ok=3 changed=1 unreachable=0 failed=0
```

Important values:

``` text
unreachable=0
failed=0
```

This means the playbook completed successfully. ✅

------------------------------------------------------------------------

# 1️⃣3️⃣ Verify the Nginx Service State

### 📍 Run on: `ansibletest-1`

Check whether Nginx is running:

``` bash
ansible all -i inventory.ini -a "systemctl is-active nginx"
```

Expected:

``` text
active
```

Check whether Nginx is enabled at boot:

``` bash
ansible all -i inventory.ini -a "systemctl is-enabled nginx"
```

Expected:

``` text
enabled
```

------------------------------------------------------------------------

# 1️⃣4️⃣ Optional: Check Nginx State Using a YAML Playbook

### 📍 Run on: `ansibletest-1`

Create:

``` bash
nano check-nginx.yml
```

Add:

``` yaml
---
- name: Check Nginx Status
  hosts: webservers
  become: yes

  tasks:

    - name: Get Nginx Service Status
      command: systemctl is-active nginx
      register: nginx_status
      changed_when: false

    - name: Display Nginx Status
      debug:
        msg: "Nginx State = {{ nginx_status.stdout }}"
```

Run:

``` bash
ansible-playbook -i inventory.ini check-nginx.yml
```

Expected:

``` text
Nginx State = active
```

------------------------------------------------------------------------

# 📘 Understanding `state` in Ansible

## Package State

``` yaml
state: present
```

Means the package **must be installed**.

``` yaml
state: absent
```

Means the package **must be removed**.

## Service State

``` yaml
state: started
```

Means the service **must be running**.

``` yaml
state: stopped
```

Means the service **must be stopped**.

``` yaml
state: restarted
```

Means the service should be **restarted**.

## Enable Service at Boot

``` yaml
enabled: yes
```

Means the service should start automatically after a server reboot.

### Quick Reference

  Setting              Meaning
  -------------------- -----------------------------------------
  `state: present`     Package should be installed
  `state: absent`      Package should be removed
  `state: started`     Service should be running
  `state: stopped`     Service should be stopped
  `state: restarted`   Service should be restarted
  `enabled: yes`       Start automatically after reboot
  `enabled: no`        Do not start automatically after reboot

> **Important:** `state=true` is generally not the syntax used for
> package/service state. `state` uses values such as `present`,
> `absent`, `started`, and `stopped`. Boolean values such as `yes/no` or
> `true/false` are commonly used with options such as `enabled`.

------------------------------------------------------------------------

# ⚡ Quick Command Reference

## 🖥️ Server 1 --- `ansibletest-1`

### Install Ansible

``` bash
sudo apt update
sudo apt install ansible -y
ansible --version
```

### Configure Passwordless SSH

``` bash
ssh-keygen -t rsa
ssh-copy-id rushiawslabs@<SERVER-2-IP>
ssh rushiawslabs@<SERVER-2-IP>
```

------------------------------------------------------------------------

## 🖥️ Server 2 --- `ansibletest-2`

### Configure Sudo Permission

``` bash
sudo vi /etc/sudoers
```

Add:

``` text
rushiawslabs ALL=(ALL) NOPASSWD: ALL
```

Return to Server 1:

``` bash
exit
```

------------------------------------------------------------------------

## 🖥️ Back on Server 1 --- `ansibletest-1`

### Create Project and Inventory

``` bash
mkdir -p ~/ansible-project
cd ~/ansible-project
nano inventory.ini
```

### Test Connectivity

``` bash
ansible all -i inventory.ini -m ping
```

### Create and Run Playbook

``` bash
nano nginx.yml
ansible-playbook -i inventory.ini nginx.yml --syntax-check
ansible-playbook -i inventory.ini nginx.yml
```

### Verify Nginx

``` bash
ansible all -i inventory.ini -a "systemctl is-active nginx"
ansible all -i inventory.ini -a "systemctl is-enabled nginx"
```

------------------------------------------------------------------------

# 🔄 Complete Ansible Workflow

``` text
Install Ansible on ansibletest-1
                │
                ▼
        Generate SSH Key
                │
                ▼
     Copy Key to ansibletest-2
                │
                ▼
       Passwordless SSH
                │
                ▼
   Configure Passwordless Sudo
                │
                ▼
       Create inventory.ini
                │
                ▼
        Ansible Ping Test
                │
                ▼
          Create nginx.yml
                │
                ▼
          Syntax Check
                │
                ▼
          Run Playbook
                │
                ▼
      Nginx Installed & Started
                │
                ▼
    Check Active/Enabled State
                │
                ▼
             SUCCESS ✅
```

------------------------------------------------------------------------

## ✅ Final Result

After completing this lab:

-   Ansible is installed on `ansibletest-1`.
-   `ansibletest-1` can connect to `ansibletest-2` using passwordless
    SSH.
-   `rushiawslabs` has passwordless sudo permission on the managed
    server.
-   The managed server is configured in `inventory.ini`.
-   Ansible connectivity is verified using the `ping` module.
-   Nginx is installed, started, and enabled using `nginx.yml`.
-   Nginx service state is verified from the Ansible control server.

------------------------------------------------------------------------

**Ansible Control Node → Inventory → Passwordless SSH → Sudo → Playbook
→ Managed Node → State Verification**
