#!/bin/sh

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Preparing the VM. This may take some time depending upon the setup.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      timedatectl set-timezone UTC

      # Check puppet agent installed
      if [ ! -f '/usr/bin/puppet' ]; then
        cd /tmp && wget --quiet http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && rpm -Uvh ./puppetlabs-release-pc1-el-7.noarch.rpm
        yum update
        cd /tmp && wget --quiet http://yum.puppetlabs.com/el/7/PC1/x86_64/puppet-agent-1.9.3-1.el7.x86_64.rpm && rpm -Uvh ./puppet-agent-1.9.3-1.el7.x86_64.rpm
        ln -s /opt/puppetlabs/bin/puppet  /usr/bin/puppet
      fi

      # Check current puppet version
      VERSION=`/usr/bin/puppet --version`
      if [ ! $VERSION = "4.9.4" ]; then
        yum -y remove puppet*
        cd /tmp && wget --quiet http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && rpm -Uvh ./puppetlabs-release-pc1-el-7.noarch.rpm
        cd /tmp && wget --quiet http://yum.puppetlabs.com/el/7/PC1/x86_64/puppet-agent-1.9.3-1.el7.x86_64.rpm && rpm -Uvh ./puppet-agent-1.9.3-1.el7.x86_64.rpm
      fi
