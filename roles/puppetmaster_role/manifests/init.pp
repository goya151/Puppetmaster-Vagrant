# == Class: puppetmaster_role
#
# Installing puppetmaster module

class puppetmaster_role () {
  #include puppetmaster
  include puppetdb
  class { '::puppet':
    runmode               => 'cron',
    server                => true,
    server_git_repo       => false,
    server_foreman        => false,
    server_reports        => 'store',
    server_external_nodes => '',
  }

}