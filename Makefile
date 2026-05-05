default:
	git pull
	ansible-playbook -i ${COMPONENT}-dev.devmonkey.online, -e ansible_user=ec2-user -e ansible_ssh_private_key_file=wmp-ansible-v1.pem ${COMPONENT}.yml
