#!/usr/bin/bash

####################################################################################################################################
# Ansible Bootstrap Rapid Deployment for CentOS7x in Docker on Photon2x                                                            #
#                                                                                                                                  #
# CentOS7x Usage:                                                                                                                  #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/photon/ansible-playbooks/master/abrd_centos7x-on-photon2x.sh | bash -   #
#                                                                                                                                  #
#                                                                                             ErnestGWilsonII@gmail.com 2017-12-03 #
#                                                                                               https://github.com/ernestgwilsonii #
#                                                                                      https://www.linkedin.com/in/ernestgwilsonii #
####################################################################################################################################

# Update the base OS
yum -y upgrade

# Enable EPEL Repository
yum -y install wget
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm -O /tmp/epel-release-7-10.noarch.rpm
yum -y localinstall /tmp/epel-release-7-10.noarch.rpm

# Install a compiler and some pre-requisites into the OS
yum -y install python-setuptools gcc libffi-devel python-devel openssl-devel krb5-devel krb5-libs krb5-workstation git sshpass tree telnet bind-utils

# Install Python pip
easy_install pip

# Install some Python module pre-requisites
pip install pybuilder
pip install mock
pip install nose
pip install coverage
pip install cryptography
pip install xmltodict
pip install "pywinrm>=0.1.1"
pip install kerberos
pip install httplib2

# Install Ansible
pip install ansible
pip install --upgrade ansible

# Create default sample examples starting kit
mkdir -p /etc/ansible
mkdir -p /etc/ansible/files/
mkdir -p /etc/ansible/group_vars/
mkdir -p /etc/ansible/host_vars/
mkdir -p /etc/ansible/templates/
mkdir -p /etc/ansible/vault/
echo "ChangeMeToWhateverYouWantForYourAnsibleVaultEncryptionPassword" > /etc/ansible/vault/vault_pass.txt
echo "hosts" > /etc/ansible/.gitignore
echo "vault" >> /etc/ansible/.gitignore
echo "ansible_ssh_user: \"root\"" > /etc/ansible/group_vars/photon.yml
echo "ansible_ssh_pass: \"M1n1m@l!\"" >> /etc/ansible/group_vars/photon.yml
echo "ansible_ssh_port: \"22\"" >> /etc/ansible/group_vars/photon.yml
echo "ansible_connection: \"ssh\"" >> /etc/ansible/group_vars/photon.yml
echo "[CentOS7]" >> /etc/ansible/hosts
echo "localhost ansible_host=127.0.0.1" >> /etc/ansible/hosts
echo "[photon]" >> /etc/ansible/hosts
echo "photon01 ansible_host=172.28.0.101" >> /etc/ansible/hosts
echo "photon02 ansible_host=172.28.0.102" >> /etc/ansible/hosts
echo "photon03 ansible_host=172.28.0.103" >> /etc/ansible/hosts
cd /etc/ansible
wget https://raw.githubusercontent.com/ernestgwilsonii/photon/ansible-playbooks/master/Photon2x_Apply-OS-Updates-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/photon/ansible-playbooks/master/Photon2x_Install-Docker-playbook.yml
mkdir -p /etc/ansible/files/Photon2x/Docker
cd /etc/ansible/files/Photon2x/Docker
wget https://raw.githubusercontent.com/ernestgwilsonii/photon/ansible-playbooks/master/files/Photon2x/Docker/docker.service
wget https://raw.githubusercontent.com/ernestgwilsonii/photon/ansible-playbooks/master/files/Photon2x/Docker/docker.socket
cd /etc/ansible

# Create a default starting /etc/ansible/ansible.cfg
echo "[defaults]" > /etc/ansible/ansible.cfg
echo "inventory=/etc/ansible/hosts" >> /etc/ansible/ansible.cfg
echo "host_key_checking=False" >> /etc/ansible/ansible.cfg
echo "retry_files_enabled=False" >> /etc/ansible/ansible.cfg
echo "forks=100" >> /etc/ansible/ansible.cfg

# Add Ansible section to /root/.bashrc
echo " " >> /root/.bashrc
echo "# Ansible #" >> /root/.bashrc
echo "###########" >> /root/.bashrc

# Add ANSIBLE_HOST_KEY_CHECKING=False variable to .bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /root/.bashrc

# Add ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt variable to .bashrc
echo "export ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt" >> /root/.bashrc
echo " " >> /root/.bashrc

# Display the Ansible version and next steps
clear
echo ""
echo "################################################################################"
tree /etc/ansible/
echo ""
echo "################################################################################"
echo "# Welcome to Ansible! #"
echo "#######################"
echo "ansible --version"
ansible --version
# Instruct the human:
echo ""
echo " # Next:"
echo " #######"
echo " cd /etc/ansible"
echo " ansible --version"
echo "################################################################################"
echo ""

