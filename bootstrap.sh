#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC
#      sudo echo "192.155.89.90 apt.puppetlabs.com" >> /etc/hosts
#      sudo echo "217.196.149.50 postgresql.org" >> /etc/hosts

      # Check puppet agent installed
      if [ ! -f '/usr/bin/puppet' ]; then
        cd /tmp && wget https://apt.puppetlabs.com/puppet5-release-xenial.deb && apt-get install ./puppet5-release-xenial.deb
        apt-get -qq update
        cd /tmp && wget https://apt.puppetlabs.com/pool/xenial/puppet5/p/puppet-agent/puppet-agent_5.0.1-1xenial_amd64.deb && apt-get install ./puppet-agent_5.0.1-1xenial_amd64.deb
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "5.3.3" ]; then
        apt-get -y purge puppet*
        cd /tmp && wget https://apt.puppetlabs.com/puppet5-release-xenial.deb && apt-get install ./puppet5-release-xenial.deb
        cd /tmp && wget https://apt.puppetlabs.com/pool/xenial/puppet5/p/puppet-agent/puppet-agent_$VERSION-1xenial_amd64.deb && apt-get install ./puppet-agent_$VERSION-1xenial_amd64.deb
      fi
