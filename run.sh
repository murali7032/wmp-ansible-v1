if [ -e "$1" ]; then
  echo Input Missing
  exit 1
fi
echo "Running Following Command"
echo "#######################"
echo ansible-playbook -i ${1}-dev.devmonkey.online, -e ansible_user=ec2-user -e ansible_ssh_private_key_file=wmp-ansible-v1.pem ${1}.yml
echo "#######################"
git pull ;  ansible-playbook -i ${1}-dev.devmonkey.online, -e ansible_user=ec2-user -e ansible_ssh_private_key_file=wmp-ansible-v1.pem ${1}.yml
