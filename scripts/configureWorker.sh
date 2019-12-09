#! /bin/bash

echo -e "\nProvisioning worker"
apt-get install -y sshpass
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@k8s-master-node:/tmp/kubeadm_join_cmd.sh .
sudo sh ./kubeadm_join_cmd.sh
