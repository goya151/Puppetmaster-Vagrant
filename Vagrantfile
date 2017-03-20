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
  puppet_opts << "--verbose --debug"   # debug output
else
  puppet_opts << "--logdest /dev/null" # silent output
end

provision_puppet = -> (box, ip, role) {
  box.vm.provision "shell", path: "bootstrap.sh"
  box.vm.provision "puppet" do |puppet|
    puppet.environment = 'development'
    puppet.module_path = ["manifests", "modules", "roles"]
    puppet.manifest_file = "site.pp"
    puppet.manifests_path = "manifests"
    puppet.environment_path = "environments"
    puppet.hiera_config_path = "hiera/hiera.yaml"
    puppet.facter = {role: role}
    puppet.options = puppet_opts
  end
  box.vm.provision "shell", inline: "
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Process is complete. Some information about this VM:
echo +++ IP  information +++; echo $(ip a | grep 'inet' | cut -f1 -d '/' | grep '192' )
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
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  #Here place for setting for proxy server
  #config.proxy.http     = "http://172.17.100.196:8080"
  #config.proxy.https    = "http://172.17.100.196:8080"
  #config.proxy.no_proxy = "localhost,127.0.0.1,192.168.0.0/24"

#Configurations for servers

  config.vm.define 'puppetmaster' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    box.vm.host_name = 'puppetmaster.dev'
    box.vm.network "private_network", ip: "192.168.12.10"
    configure_providers.call(box, "puppetmaster.dev", 8192, 8)
    provision_puppet.call(box, "192.168.12.10", "puppetmaster")
  end

  config.vm.define 'mailserver' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    box.vm.host_name = 'mailserver.dev'
    box.vm.network "private_network", ip: "192.168.12.11"
    configure_providers.call(box, "mailserver.dev", 2048, 8)
    provision_puppet.call(box, "192.168.12.11", "mailserver")
  end

  config.vm.define 'test-node01' do |box|
    box.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    box.vm.host_name = 'test-node01.dev'
    box.vm.network "private_network", ip: "192.168.12.52"
    configure_providers.call(box, "test-node01.dev", 1024, 8)
    provision_puppet.call(box, "192.168.12.52", "test-node01")
  end

end
