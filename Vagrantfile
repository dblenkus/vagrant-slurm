# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


# Configure host names and IP addresses.
machines = {
  "controller"         => "10.10.10.3",
  "worker1"            => "10.10.10.4",
  "worker2"            => "10.10.10.5",
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # NOTE: Official "ubuntu/xenial64" bod doesn't have VirtualBox Guest Additions
  # installed
  config.vm.box = "geerlingguy/ubuntu1604"

  # Prevent Vagrant from replacing the default insecure SSH key. Since we only
  # use Vagrant for provisioning the testing servers, this is not an issue.
  # Also, this speeds-up provisioning.
  config.ssh.insert_key = false

  # Prevent Vagrant from mounting the default /vagrant synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder "storage", "/storage/local"
  config.vm.synced_folder "../genialis-base/data", "/storage/genialis"

  #VM configuration
  config.vm.provider :virtualbox do |vb|
    # Required for 64-bit guest OS
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    vb.customize ["modifyvm", :id, "--memory", "512"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
  end

  # VM specifications
  machines.each do |name, ip|
    config.vm.define name do |host|
      host.vm.hostname = "#{name}.slurm.local"
      host.vm.network "private_network", ip: ip

      #VM provisioning
      host.vm.provision "file", source: "provision/slurm.conf", destination: "slurm.conf"
      host.vm.provision "file", source: "provision/munge.key", destination: "munge.key"
      host.vm.provision :shell, :path => "provision/all.sh"
 
      if name == "controller"
        host.vm.provision "shell", inline: "slurmctld"
      end

      if name.start_with?("worker")
        host.vm.provision :shell, :path => "provision/docker.sh"
        host.vm.provision "shell", inline: "slurmd"
      end
    end
  end

end
