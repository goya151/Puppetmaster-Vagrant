#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC
      sudo echo "192.155.89.90 apt.puppetlabs.com" >> /etc/hosts
      sudo echo "217.196.149.50 postgresql.org" >> /etc/hosts

      # Check puppet agent installed
      if [ ! -f '/usr/bin/puppet' ]; then
        cd /tmp && wget --quiet http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && apt-get install -qq ./puppetlabs-release-pc1-xenial.deb
        apt-get -qq update
        cd /tmp && wget --quiet http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.9.3-1xenial_amd64.deb && apt-get install -qq ./puppet-agent_1.9.3-1xenial_amd64.deb
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.9.4" ]; then
        apt-get -y purge puppet*
        cd /tmp && wget --quiet http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && apt-get install -qq ./puppetlabs-release-pc1-xenial.deb
        cd /tmp && wget --quiet http://apt.puppetlabs.com/pool/xenial/PC1/p/puppet-agent/puppet-agent_1.9.3-1xenial_amd64.deb && apt-get install -qq ./puppet-agent_1.9.3-1xenial_amd64.deb
      fi
