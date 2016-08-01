# == Class: http_server_role
#
#

class http_server_role (
  $apache_vhost = hiera ('apache_vhost'),

) {

  class { 'apache':
    #default_mods        => false,
    default_confd_files => false,
    default_vhost       => false,
  }

  create_resources(apache::vhost, $apache_vhost)

}
