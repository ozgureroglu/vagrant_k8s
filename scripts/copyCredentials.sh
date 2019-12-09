# copy credentials to vagrant user home (to any user if you are not on vbox)
echo -e "\tCopying credentials to vagrant user"
# sudo --user=vagrant mkdir -p /home/vagrant/.kube
# cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
# chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
