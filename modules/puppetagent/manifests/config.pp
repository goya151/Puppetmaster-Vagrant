# == Class puppetagent::config
# Manage all config files for puppet agent
#

class puppetagent::config(
    $puppetserver        = $::puppetagent::puppetserver,
    $working_environment = $::puppetagent::working_environment,
    $puppetdbserver      = $::puppetagent::puppetdbserver,
    $puppetdbport        = $::puppetagent::puppetdbport
) {

  file { "${settings::confdir}/puppet.conf":
    ensure  => file,
    content => template('puppetagent/puppet.conf.erb'),
    require => Package['puppet-agent'];
  }
  file { "${settings::confdir}/puppetdb.conf":
    ensure  => file,
    content => template('puppetagent/puppetdb.conf.erb'),
    require => Package['puppet-agent'];
  }
}