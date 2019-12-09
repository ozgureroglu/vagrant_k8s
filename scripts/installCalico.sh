
# install Calico pod network addon
# For alternatives solutions look at the page: https://kubernetes.io/docs/concepts/cluster-administration/addons/
export KUBECONFIG=/home/vagrant/.kube/config

echo -e "\tInstalling pod network Calico"
# RBAC based calico: requires the RBAC enabled kuernetes
curl https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml -O
kubectl apply -f rbac-kdd.yaml

curl https://docs.projectcalico.org/v3.9/manifests/calico.yaml -O
kubectl apply -f calico.yaml
