#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC

      # Check puppet agent installed
      if [ ! -f '/usr/bin/puppet' ]; then
        cd /tmp && wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && dpkg -i ./puppetlabs-release-pc1-xenial.deb
        apt-get update
        cd /tmp && wget http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.8.2-1xenial_amd64.deb && dpkg -i ./puppet-agent_1.8.2-1xenial_amd64.deb
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.8.1" ]; then
        apt-get -y purge puppet*
        cd /tmp && wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && dpkg -i ./puppetlabs-release-pc1-xenial.deb
        cd /tmp && wget http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.8.2-1xenial_amd64.deb && dpkg -i ./puppet-agent_1.8.2-1xenial_amd64.deb
      fi