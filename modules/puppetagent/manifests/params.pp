# == Class puppetagent::params
# Default values for puppetagent

class puppetagent::params {
  $puppetserver        = 'puppetmaster.magalog.net'
  $working_environment = 'production'
  $puppetdbserver      = 'puppetmaster.magalog.net'
  $puppetdbport        = '8081'
}