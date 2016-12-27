#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC

      if [ ! -f '/usr/bin/puppet' ]; then
        echo "192.155.89.90 apt.puppetlabs.com" >> /etc/hosts

        cd /tmp && wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && dpkg -i ./puppetlabs-release-pc1-xenial.deb
        apt update
        cd /tmp && wget http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.8.2-1xenial_amd64.deb && dpkg -i ./puppet-agent_1.8.2-1xenial_amd64.deb
        #apt install -y puppet-agent=1.8.2-1xenial
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi


      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.8.1" ]; then
        apt-get -y purge puppet*
        echo "192.155.89.90 apt.puppetlabs.com" >> /etc/hosts

        cd /tmp && wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && dpkg -i ./puppetlabs-release-pc1-xenial.deb
        cd /tmp && wget http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.8.2-1xenial_amd64.deb && dpkg -i ./puppet-agent_1.8.2-1xenial_amd64.deb
        #apt install -y puppet-agent=1.8.2-1xenial
      fi

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Process is complete. Some information about this VM:
echo +++ IP  information +++; echo $(ip a | grep 'inet' | cut -f1 -d '/' | grep '192' )
echo +++ SSH information +++; echo vagrant ssh $(hostname | cut -f 1 -d '.')
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++
echo VM is ready.
