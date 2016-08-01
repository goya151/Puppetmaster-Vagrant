#
# Creates http checks of clients sites
#
class monitoring_server_role::sites_checks (
  $site_checks               = $monitoring_server_role::params::site_checks,
  $site_checks_notifications = $monitoring_server_role::params::site_checks_notifications,
){

  icinga2::object::host { 'sites-check-host':
    display_name     => 'sites-check-host',
    ipv4_address     => '127.0.0.1',
    groups           => ['linux-servers'],
    vars             => {
      os              => 'linux',
      virtual_machine => 'true',
      distro          => $::operatingsystem,
      notification    => {
        mail           => '{ groups = [ "icingaadmins" ] }'
      },
    },
    target_dir       => '/etc/icinga2/objects/hosts',
    target_file_name => 'sites-check-host.conf',
  }
  file { '/etc/icinga2/objects/checkcommands/site_check.conf':
    ensure => present,
    source => 'puppet:///modules/monitoring_server_role/site_check.conf',
    notify => Service['icinga2'];
  }

  create_resources ('icinga2::object::service', $site_checks)
  create_resources ('icinga2::object::notification', $site_checks_notifications)

}