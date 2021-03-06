## Development environment

### First start:

#### Install necessary dependencies
VirtualBox - https://www.virtualbox.org/wiki/Downloads
Vagrant   - http://www.vagrantup.com/downloads.html

`Vagrant 1.9.1`

Have to be installed vagrant plugins:
```
librarian-puppet (2.2.3)
vagrant-cachier (1.2.1)
vagrant-librarian-puppet (0.9.2)
vagrant-share (1.1.7, system)
```

For manual install dependencies via librarian:
```
librarian-puppet update --verbose
```

For first start needs some time for download basebox from internet.<br/>

| Vagrant command | Description                                                   |
| -------------   |:--------------------------------------------------------------|
| status          | output status of the vagrant machine                          |
| halt            | suspend VM                                                    |
| up              | starts and provisions the vagrant environment                 |
| ssh             | connects to machine via SSH                                   |
| destroy         | stops and deletes all traces of the vagrant machine           |
| provision       | provisions the vagrant machine                                |
| reload          | restarts vagrant machine, loads new Vagrantfile configuration |
| resume          | resume a suspended vagrant machine                            |

### Debug mode:
For debug mode you can use parameters before command 'vagrant':
- PUPPET_DEBUG=1   - Display all regular output
- PUPPET_DEBUG=2   - Display all messages with "--verbose" and "--debug" keys

By default all regular output will be redirected to '/dev/null'

#### Vagrantfile

  Located in root folder of project. Contain all configurations for starting VMs via vagrant.

  For adding a new server need to add section after comment "#Configurations for servers"
```
   config.vm.define 'test-server' do |box|
    box.vm.box = 'trusty64'                                     #name of basebox
    box.vm.box_url= 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    box.vm.host_name = 'test-server.dev'                        #hostname
    box.vm.network "private_network", ip: "192.168.12.12"       #network configuration
    configure_providers.call(box, "test-server", 1024, 2)       #configuration for providers
    provision_puppet.call(box, "192.168.12.12", "test-server")  #configuration for puppet
   end
```

## Production environment

  On nodes puppet-agent preinstalled or installed via script install.sh with all dependencies.

  After Creating a node we need to check a hostname,
```
hostname -f
```
  clean old sertificates from puppet folders:
```
find /etc/puppetlabs/puppet/ssl -name hostname.dev.pem -delete
```
and after make a first start:
```
puppet agent -t --server puppetmaster.dev  #After last changes server name is already in agent configs
```


On puppet master sign a node:
```
puppet cert sign hostname.dev
```
and on the node start puppet provision again with environment:
```
puppet agent -t --environment development
```

### Puppet structure:

  Has been used puppet v.4 with hiera.

All packages can be found on http://apt.puppetlabs.com/

- hiera:
     - development  -  folder for .yaml configuration files for development environment
     - production   -  folder for .yaml configuration files for production environment
     - common.yaml - configuration for all VMs
     - hiera.yaml  - main hiera configuration

- manifests - main configuration for puppet (site.pp)

- modules  - contains all external modules

- roles    - contains roles for servers

- environment.conf  -  configuration for puppet environment
