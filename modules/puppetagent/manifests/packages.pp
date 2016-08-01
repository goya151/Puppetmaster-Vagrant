# == Class puppetagent::packages
# Setup all needed packages for puppet agent
# Will not setup the correct repository server
# See here for more: https://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

class puppetagent::packages() {

  $puppet_agent_version = $::lsbdistcodename ? {
    'trusty'  => '1.1.0-1trusty',
    'precise' => '1.1.0-1precise',
    default   => installed,
  }

  package { 'puppet-agent':
    ensure => $puppet_agent_version,
  }

  package {'puppetdb-terminus':
    ensure => '2.3.4-1puppetlabs1',
  }
}
