#!/bin/bash

echo -e "\nProvisioning master"
# ip of this box
IP_ADDR=`ifconfig eth1 | grep broadcast | awk '{print $2}'| cut -f2 -d:`

# install k8s master
HOST_NAME=$(hostname -s)
echo -e "\tInitializing kubernetes"
kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16

# #copying credentials to regular user - vagrant
# sudo --user=vagrant mkdir -p /home/vagrant/.kube
# cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/admin.conf
# chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/admin.conf
