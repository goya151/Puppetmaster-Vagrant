#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC
      echo "192.168.12.10 puppetmaster.dev" >> /etc/hosts

      AGENT_VERSION="5.3.3"

      VERSION=`/usr/bin/puppet --version`

      if [ ! -f '/usr/bin/puppet' ]; then
        cd /tmp && wget https://apt.puppetlabs.com/puppet5-release-xenial.deb && apt-get install ./puppet5-release-xenial.deb
        apt-get -qq update
        cd /tmp && wget https://apt.puppetlabs.com/pool/xenial/puppet5/p/puppet-agent/puppet-agent_$AGENT_VERSION-1xenial_amd64.deb && apt-get install ./puppet-agent_$AGENT_VERSION-1xenial_amd64.deb
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi
      if [ ! $VERSION = "5.3.3" ]; then
        apt-get -y purge puppet*
        cd /tmp && wget https://apt.puppetlabs.com/puppet5-release-xenial.deb && apt-get install ./puppet5-release-xenial.deb
        cd /tmp && wget https://apt.puppetlabs.com/pool/xenial/puppet5/p/puppet-agent/puppet-agent_$AGENT_VERSION-1xenial_amd64.deb && apt-get install ./puppet-agent_$AGENT_VERSION-1xenial_amd64.deb
      fi
