#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC
      if [ ! -f /usr/bin/puppet ]; then
        cd /tmp
        wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
        dpkg --force-all -i /tmp/puppetlabs-release-pc1-xenial.deb
        apt-get update
        apt-get install -y puppet-agent=1.8.0-1xenial
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.8.0" ]; then
        apt-get -y purge puppet*
        cd /tmp
        wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
        apt-get install /tmp/puppetlabs-release-pc1-xenial.deb
        apt-get update
        apt-get install -y puppet-agent=1.8.0-1xenial
        #ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

puppet apply --modulepath /etc/puppetlabs/code/environments/development/modules:/etc/puppetlabs/code/environments/development/roles --hiera_config=/etc/puppetlabs/code/environments/development/hiera/hiera.yaml /etc/puppetlabs/code/environments/development/manifests/site.pp --environment=development $1

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Process is complete. Some information about this VM:
echo +++ IP  information +++; echo $(ip a | grep 'inet' | cut -f1 -d '/' | grep '192' )
echo +++ SSH information +++; echo vagrant ssh $(hostname | cut -f 1 -d '.')
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
echo VM is ready.


