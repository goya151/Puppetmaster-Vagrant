# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

RUBY_DEP_GEM_SILENCE_WARNINGS=1

configure_providers = -> (box, name, memory, cpus = 1) {
  box.vm.provider :virtualbox do |v|
     v.name = name
     v.memory = memory
     v.cpus = cpus
  end
}

# external env vars
puppet_opts =  ENV["PUPPET_OPTIONS"] || ""

if ENV["PUPPET_DEBUG"] == "1"
  # regular output
elsif ENV["PUPPET_DEBUG"] == "2"
  puppet_opts << " --verbose --debug"
else
  #puppet_opts << "&>/dev/null"
end

# This is a fix to run puppet 4.5.3 with vagrant
$script = <<SHELL
      sudo timedatectl set-timezone UTC
      if [ ! -f /usr/bin/puppet ]; then
        dpkg --install - <(curl -o- http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb)
        sudo apt-get update
        sudo apt-get install -y puppet-agent=1.5.3-1xenial
        sudo ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.5.3" ]; then
        sudo apt-get -y purge puppet-common puppet
        wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
        sudo apt-get install ./puppetlabs-release-pc1-xenial.deb
        sudo apt-get update
        sudo apt-get install -y puppet-agent=1.5.3-1xenial
        sudo ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi
SHELL

provision_puppet = -> (box, ip, role) {
    box.vm.provision "shell", inline: "
    echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo Preparing the VM. This may take some time depending upon the setup.
    echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    box.vm.provision "shell", inline: $script

    box.vm.provision "shell", args: [puppet_opts], inline: 'sudo puppet apply --modulepath /etc/puppetlabs/code/environments/development/modules:/etc/puppetlabs/code/environments/development/roles --hiera_config=/etc/puppetlabs/code/environments/development/hiera/hiera.yaml /etc/puppetlabs/code/environments/development/manifests/site.pp --environment=development $1'

    box.vm.provision "shell", inline: "
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo Process is complete. Some information about this VM:
    echo +++ IP information +++; echo $(ip a | grep 'inet' | cut -f1 -d '/' | grep '192' )
    echo +++ SSH information +++; echo vagrant ssh $(hostname | cut -f 1 -d '.')
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo VM is ready."
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # disable the default shared folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments/development"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
#  config.ssh.forward_agent = true
#  config.ssh.insert_key = 'true'
#  config.ssh.private_key_path = "/home/maxim/.ssh/id_rsa"
#  config.ssh.username = "puppet"

  config.proxy.http     = "http://172.17.100.196:8080"
  config.proxy.https    = "http://172.17.100.196:8080"
  config.proxy.no_proxy = "localhost,127.0.0.1"


#Configurations for servers

  config.vm.define 'puppetmaster' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    box.vm.host_name = 'puppetmaster.dev'
    box.vm.network "private_network", ip: "192.168.12.12"
    configure_providers.call(box, "puppetmaster", 4096, 4)
    provision_puppet.call(box, "192.168.12.12", "puppetmaster")
  end

  config.vm.define 'test-node01' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    #box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/vivid/20150903/vivid-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-node01.dev'
    box.vm.network "private_network", ip: "192.168.12.13"
    configure_providers.call(box, "test-node01", 1024, 1)
    provision_puppet.call(box, "192.168.12.13", "test-node01")
  end
end
