# This repository is public

ALL code in here should be considered safe to be public.  Keys, passwords, etc.. should NEVER be in this repository.

# OpenStack on Ansible with Vagrant

This repository contains script that will deploy OpenStack into Vagrant virtual
machines. These scripts are based on the [Official OpenStack
Docmentation](http://docs.openstack.org/), except where
otherwise noted.

## Install prereqs

You'll need to install:

* [Vagrant](http://vagrantup.com) - For a developer environment only
* [Ansible](http://ansible.github.com) - Use 1.7 or higher
* [python-netaddr](https://pypi.python.org/pypi/netaddr/)
* [python-novaclient](https://pypi.python.org/pypi/python-novaclient) (recommended)

To get started with Ansible, install the prerequisites,
grab the git repo and source the appropriate file to set your environment
variables, no other installation is required:

	brew install ansible or sudo apt-get install ansible or sudo pip install ansible
	sudo pip install netaddr python-novaclient

## Get an Ubuntu 14.04 (precise) box

Download a 64-bit Ubuntu Vagrant box:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

This repository uses a submodule that contains some custom Ansible modules for
OpenStack, so there's an extra command required after cloning the repo:

    git clone http://github.com/packethost/playbooks.git
    cd openstack-ansible
    git submodule update --init

## Bring up the cloud

    make

This will boot three VMs (controller, network, storage, and a compute node),
install OpenStack, and attempt to boot a test VM inside of OpenStack.

If everything works, you should be able to ssh to the instance from any
of your vagrant hosts:

	cd testcases/standard; vagrant ssh compute (for the compute instance)

If you get connection refused, you may want to confirm that your vagrant key is available:

	ssh-add ~/.vagrant.d/insecure_private_key

## Vagrant hosts

The hosts for the standard configuration are:

 * 10.1.0.2 (controller)
 * 10.1.0.3 (compute node #1)
 * 10.1.0.4 (neutron host)
 * 10.1.0.5 (swift storage host)

You should be able to ssh to these VMs (`vagrant status`). 

## Interacting with your cloud

You can interact with your cloud directly from your desktop, assuming that you
have the [python-novaclient](http://pypi.python.org/pypi/python-novaclient/)
installed.

Note that the openrc file will be created on the controller by default.
