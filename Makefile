ANSIBLE=ansible-playbook

.PHONY: standard single openstack-ansible-modules standard-vms single-vms openstack openstack-single demo single-demo destroy destroy-single

standard: openstack demo

single: openstack-single single-demo

openstack: openstack-ansible-modules standard-vms
	$(ANSIBLE) -i testcases/standard/ansible_hosts openstack.yaml

openstack-single: openstack-ansible-modules single-vms
	$(ANSIBLE) -i testcases/single/ansible_hosts openstack.yaml

openstack-ansible-modules:
	git submodule init
	git submodule update

# vagrant-private-key-perms:
#  	chmod 600 vagrant_private_key

standard-vms:
	cd testcases/standard; vagrant up

single-vms:
	cd testcases/single; vagrant up

demo: openstack-ansible-modules standard-vms openstack
	$(ANSIBLE) -i testcases/standard/ansible_hosts demo.yaml

single-demo: openstack-ansible-modules single-vms openstack-single
	$(ANSIBLE) -i testcases/single/ansible_hosts demo.yaml

destroy:
	cd testcases/standard; vagrant destroy --force

destroy-single:
	cd testcases/single; vagrant destroy --force
