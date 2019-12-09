#!/bin/bash
# Install the K8s dashboard
echo -e "\tInstalling Kubernetes Dashboard"
export KUBECONFIG=/home/vagrant/.kube/config
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# Create an admin account called k8s-admin
kubectl --namespace kube-system create serviceaccount k8s-admin
kubectl create clusterrolebinding k8s-admin --serviceaccount=kube-system:k8s-admin --clusterrole=cluster-admin
