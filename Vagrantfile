# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

RUBY_DEP_GEM_SILENCE_WARNINGS=1

Vagrant.require_version ">= 1.8.7"


configure_providers = -> (box, name, memory, cpus = 2) {
  box.vm.provider :virtualbox do |v|
     v.name = name
     v.memory = memory
     v.cpus = cpus
  end
}


# external env vars
puppet_opts =  ENV["PUPPET_OPTIONS"] || ""

if ENV["PUPPET_DEBUG"] == "1"          # regular output
elsif ENV["PUPPET_DEBUG"] == "2"
  puppet_opts << " --verbose --debug"  # debug output
else
  puppet_opts << "--logdest /dev/null" # silent output
end


provision_puppet = -> (box, ip, role) {
    box.vm.provision "shell", args: [puppet_opts], path: "provision.sh"
}


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # disable the default shared folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments/development"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = false

  config.ssh.insert_key = false
  #config.ssh.username = 'vagrant'
  #config.ssh.password = 'vagrant'
  #config.ssh.private_key_path = "/home/maxim/.ssh/id_rsa"

  #Here place for setting of your proxy server
  #config.proxy.http     = "http://172.17.100.196:8080"
  #config.proxy.https    = "http://172.17.100.196:8080"
  #config.proxy.no_proxy = "localhost,127.0.0.1,192.168.0.0/24"

  #config.vm.provision "puppet" do |puppet|
#      puppet.module_path = "modules"
#      puppet.module_path = "roles"
#      puppet.manifest_file = "site.pp"
#      puppet.hiera_config_path = "./hiera/hiera.yaml ./manifests/site.pp"
#      puppet.environment = "development"
#      puppet.options = "--verbose --debug"
#  end


#Configurations for servers

  config.vm.define 'puppetmaster' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    box.vm.host_name = 'puppetmaster.dev'
    box.vm.network "public_network", use_dhcp_assigned_default_route: true
    configure_providers.call(box, "puppetmaster.dev", 8196, 16)
    provision_puppet.call(box, "192.168.245.50", "puppetmaster")
  end

  config.vm.define 'repository' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    box.vm.host_name = 'repository.dev'
    box.vm.network "public_network", use_dhcp_assigned_default_route: true
    configure_providers.call(box, "repository.dev", 2048, 16)
    provision_puppet.call(box, "192.168.245.51", "repository-server")
  end

  config.vm.define 'test-node01' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    #box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/vivid/20150903/vivid-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-node01.dev'
    box.vm.network "public_network", ip: "192.168.245.52" #use_dhcp_assigned_default_route: true
    configure_providers.call(box, "test-node01.dev", 512, 8)
    provision_puppet.call(box, "192.168.245.52", "test-node01")
  end

  config.vm.define 'test-node02' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    box.vm.host_name = 'test-node02.dev'
    box.vm.network "public_network", ip: "192.168.245.53"
    configure_providers.call(box, "test-node02.dev", 2048, 16)
    provision_puppet.call(box, "192.168.245.53", "test-node02")

  end
  config.vm.define 'test-node03' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-puppet'
    box.vm.host_name = 'test-node03.dev'
    box.vm.network "public_network", ip: "192.168.245.54"
    configure_providers.call(box, "test-node03.dev", 2048, 16)
    provision_puppet.call(box, "192.168.245.54", "test-node03")
  end

end
