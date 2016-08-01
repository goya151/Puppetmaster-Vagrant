# == Class puppetmaster
# Setup puppetmaster and auto-pull script.
# Puppet repository has to be setup before:
# https://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

class puppetmaster (){

  include puppetmaster::packages
  include puppetmaster::config

}