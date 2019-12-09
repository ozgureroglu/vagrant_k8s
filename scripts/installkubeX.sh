#!/bin/bash

echo -e "\tInstalling Kubernetes Packages"
# You will install these packages on all of your machines:
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#before-you-begin
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Kubelet swap alaninin tamamen kapali olmasini istedigi icin
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
