# -*- mode: ruby -*-
# vi: set ft=ruby :

# ---- Configuration variables ----
GUI               = false # Enable/Disable GUI
RAM               = 3072   # Default memory size in MB
CPU               = 2     # Default core sayisi

# Network configuration
DOMAIN            = ".myk8s.org"
NETWORK           = "192.170.50."
NETMASK           = "255.255.255.0"

# Default Virtualbox .box
BOX               = 'debian/stretch64'

# VBox sanal makina tanimlarim
HOSTS = {
  "k8s-master-node" => [NETWORK+"11", RAM, GUI, CPU, BOX,"master"],
  "k8s-worker-node1" => [NETWORK+"12", RAM, GUI, CPU, BOX,"worker"],
  "k8s-worker-node2" => [NETWORK+"13", RAM, GUI, CPU, BOX,"worker"],  
}

# Hostmanager kurulumu gereklidir.
# vagrant plugin install vagrant-hostmanager
Vagrant.configure("2") do |config|
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
#     config.disksize.size = '20GB'

    # Sanal makinalari olusturuyorum
    HOSTS.each do | (name, cfg) |
      ipaddr, ram, gui, cpu, box, type = cfg

      config.vm.define name do |machine|
        machine.vm.box   = box
        machine.vm.guest = :debian

        machine.vm.provider "virtualbox" do |vbox|
          vbox.gui    = gui
          vbox.memory = ram
          vbox.name = name
          vbox.cpus = cpu
        end

        machine.vm.hostname = name + DOMAIN
        machine.vm.network 'private_network', ip: ipaddr, netmask: NETMASK
#         machine.vm.network "public_network", use_dhcp_assigned_default_route: true
        machine.hostmanager.aliases = [name ]

        # -------- PROVISION -------------------
        # hostmanager provisioner
        config.vm.provision :hostmanager

        # provision all my hosts with ansible
         config.vm.provision :ansible do |ansible|
           ansible.playbook = "ansible/playbook.yml"
           ansible.inventory_path = "ansible/inventory"

           # Do it as root
           ansible.become = true
           # ansible.compatibility_mode = "1.8"
         end

        # call external script to install CRI
        config.vm.provision "shell", path: "scripts/commonPackages.sh"

        # call external script to install CRI
        config.vm.provision "shell", path: "scripts/dockerCRI.sh"

        # call external script to install Kubernetes
        config.vm.provision "shell", path: "scripts/installkubeX.sh"

        if type == "master"
          machine.vm.provision "shell", path: "scripts/initKubernetes.sh"
          machine.vm.provision "shell", path: "scripts/copyCredentials.sh", privileged: false
          machine.vm.provision "shell", path: "scripts/installCalico.sh", privileged: true
          machine.vm.provision "shell", path: "scripts/createJoinStatement.sh", privileged: true
          machine.vm.provision "shell", path: "scripts/installK8sDashboard.sh", privileged: false
        elsif type == "worker"
          machine.vm.provision "shell", path: "scripts/configureWorker.sh"
        end

        config.trigger.after :provision do |trigger|
          trigger.name = "Create local config"
          trigger.info = "I am running after vagrant up!!"
          trigger.run =  {path: "scripts/copyLocalConfig.sh"}
        end



      end
    end # HOSTS-each

end
