# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

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

provision_puppet = -> (box, ip, role) {
    box.vm.provision "shell", inline: "
    echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo Preparing the VM. This may take some time depending upon the setup.
    echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    # This is a fix to run puppet 4.1.0 with vagrant
    # Wait until fix is part of vagrant: https://github.com/mitchellh/vagrant/pull/5601
    box.vm.provision "shell", :inline => <<-SHELL
      if [ ! -f /usr/bin/puppet ]; then
        wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
        sudo dpkg -i puppetlabs-release-pc1-trusty.deb
        sudo apt-get update
        sudo apt-get install -y puppet-agent=1.1.0-1trusty
        sudo ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # check current puppet version
      # if it isn't 4.1.0 version, it will remove existing puppet and install version 4.1.0
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.1.0" ]; then
        sudo apt-get -y purge puppet-common puppet
        wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
        sudo dpkg -i puppetlabs-release-pc1-trusty.deb
        sudo apt-get update
        sudo apt-get install -y puppet-agent=1.1.0-1trusty
        sudo ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi
    SHELL

    box.vm.provision "shell", args: [puppet_opts], inline: 'sudo puppet apply --modulepath /etc/puppetlabs/code/environments/development/modules:/etc/puppetlabs/code/environments/development/roles --hiera_config=/etc/puppetlabs/code/environments/development/hiera/hiera.yaml /etc/puppetlabs/code/environments/development/manifests/site.pp --environment=development $1'

    box.vm.provision "shell", inline: "
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo Process is complete. Some information about this VM:
    echo +++ IP information +++; echo $(ip a | grep 'eth' | grep 'inet' | cut -f1 -d '/' | grep '192' )
    echo +++ SSH information +++; echo vagrant ssh $(hostname | cut -f 1 -d '.')
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo NOTE: VM is ready."
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # disable the default shared folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments/development"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.ssh.insert_key = false

  client_private_key_path = '.key/id_rsa'

  config.proxy.http     = "http://172.17.100.196:8080"
  config.proxy.https    = "http://172.17.100.196:8080"
  config.proxy.no_proxy = "localhost,127.0.0.1"

#Configurations for servers

  config.vm.define 'puppetmaster' do |box|
    box.vm.box = 'trusty64'
    box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'puppetmaster.dev'
    box.vm.network "private_network", ip: "192.168.12.12"
    configure_providers.call(box, "puppetmaster", 4096, 4)
    provision_puppet.call(box, "192.168.12.12", "puppetmaster")
  end

  config.vm.define 'test-node01' do |box|
    box.vm.box = 'vivid64'
    box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/vivid/20150903/vivid-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-node01.dev'
    box.vm.network "private_network", ip: "192.168.12.13"
    configure_providers.call(box, "test-node01", 2048, 2)
    provision_puppet.call(box, "192.168.12.13", "test-node01")
  end

  config.vm.define 'test-node02' do |box|
    box.vm.box = 'trusty64'
    box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-node02.dev'
    box.vm.network "private_network", ip: "192.168.12.14"
    configure_providers.call(box, "test-node02", 2048, 2)
    provision_puppet.call(box, "172.17.19.151", "test-node02")
  end

  config.vm.define 'test-node03' do |box|
    box.vm.box = 'trusty64'
    box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-node03.dev'
    box.vm.network "private_network", ip: "192.168.12.15"
    configure_providers.call(box, "test-node03", 512, 2)
    provision_puppet.call(box, "192.168.12.15", "test-node03")
  end
end
