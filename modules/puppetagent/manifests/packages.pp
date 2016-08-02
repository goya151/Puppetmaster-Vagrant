# == Class puppetagent::packages
# Setup all needed packages for puppet agent
# Will not setup the correct repository server
# See here for more: https://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

class puppetagent::packages() {

  $puppet_agent_version = $::lsbdistcodename ? {
    'trusty'  => '1.1.0-1trusty',
    'precise' => '1.1.0-1precise',
    'xenial' => '1.5.3-1xenial',
    default   => installed,
  }

  package { 'puppet-agent':
    ensure => $puppet_agent_version,
  }

  package {'puppetdb-termini':
    ensure => '4.1.2-1puppetlabs1',
  }
}
