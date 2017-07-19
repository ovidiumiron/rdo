CENTOS=CentOS-7-x86_64-GenericCloud.qcow2 
KVM_IMG=/home/ovidiu/kvm/vms/CentOS-07-openstack_demo.qcow

prepare-image:
	@echo '************** prepare the images *****************************'
	./gen.sh
	rm $(KVM_IMG) -f
	cp $(CENTOS) $(KVM_IMG)
	qemu-img resize $(KVM_IMG) +200G
	qemu-img info $(KVM_IMG)
	sudo virsh define openstack.xml
	sudo virsh net-dhcp-leases nat

start-vm:
	@echo '************** start vm *****************************'
	sudo virsh start openstack
	sleep 3
	sudo virsh domifaddr openstack
