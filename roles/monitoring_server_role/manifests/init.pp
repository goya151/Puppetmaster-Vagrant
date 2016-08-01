# == Class: monitoring_server_role
#
#  Setup icinga2-server, icinga2-classicui, mysql-database and configure users.

class monitoring_server_role (
  $mail_domain = $monitoring_server_role::params::mail_domain,
)inherits monitoring_server_role::params {

  include pnp4nagios

  include monitoring_server_role::default_users
  include monitoring_server_role::sites_checks

  # Unfortunately, apt::key doesn't support url with auth stuff, yet.
  # So we have to use exec solution.
  exec { 'icinga-repo-key':
    command => 'wget -O - http://packages.icinga.org/icinga.key | apt-key add -',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    unless  => 'apt-key finger|grep 34410682',
    notify  => Exec['apt_update'],
  }

  # Set up an apt repo
  apt::source { 'icinga-trusty':
    location => 'http://packages.icinga.org/ubuntu',
    release  => 'icinga-trusty',
    repos    => 'main',
  }

  class { '::mysql::server':
    root_password           => 'ey5678thr4ebdsr347w',
    remove_default_accounts => true,
  }

  mysql::db { 'icinga2_data':
    user     => 'icinga2',
    password => 'ey5678thr4ebdsr347w',
    host     => 'localhost',
  }

  #Install Icinga 2:
  class { 'icinga2::server':
    server_db_type                => 'mysql',
    db_host                       => 'localhost',
    db_port                       => '3306',
    db_name                       => 'icinga2_data',
    db_user                       => 'icinga2',
    db_password                   => 'ey5678thr4ebdsr347w',
    server_install_nagios_plugins => false, #nagios_plugins will be installed on all nodes via default_role
    server_enabled_features       => ['statusdata', 'command', 'compatlog', 'perfdata', 'notifications'],
    install_mail_utils_package    => true
  }

  icinga2::object::idomysqlconnection { 'mysql_connection':
   target_dir => '/etc/icinga2/features-enabled',
   target_file_name => 'ido-pgsql.conf',
   host             => '127.0.0.1',
   port             => 3306,
   user             => 'icinga2',
   password         => 'ey5678thr4ebdsr347w',
   database         => 'icinga2_data',
   categories => ['DbCatConfig', 'DbCatState', 'DbCatAcknowledgement', 'DbCatComment', 'DbCatDowntime', 'DbCatEventHandler' ],
  }

  ensure_packages(['apache2','php5', 'libapache2-mod-php5', 'php5-mcrypt'])

  package { 'icinga2-classicui':
    ensure  => latest,
    require => [ File['icinga-trusty.list'], Exec['apt_update'] ]
  }

  # Clean icinga from defaults as we will use NRPE for all hosts
  file { ['/etc/icinga2/conf.d/apt.conf', '/etc/icinga2/conf.d/hosts.conf', '/etc/icinga2/conf.d/services.conf', '/etc/icinga2/conf.d/notifications.conf']:
    ensure => present,
    content => '',
    notify => Service['icinga2'];
  }

  #Create CheckCommand for check hosts via ssh
  #
  #Because "icinga2::object::checkcommand" working incorrectly and
  # need to invest time for fixing icinga2-module
  file { '/etc/icinga2/objects/checkcommands/ping_ssh.conf':
    ensure => present,
    source => 'puppet:///modules/monitoring_server_role/ping_ssh.conf',
    notify => Service['icinga2'];
  }

  # Castomising notifications
  file { '/etc/icinga2/conf.d/commands.conf':
    ensure => present,
    source => 'puppet:///modules/monitoring_server_role/commands.conf',
    notify => Service['icinga2'];
  }
  file { '/etc/icinga2/scripts/mail-service-notification.sh':
    ensure => present,
    source => 'puppet:///modules/monitoring_server_role/mail-service-notification.sh',
    notify => Service['icinga2'];
  }

  # Get user list from hiera/common.yaml and create users for icinga
  $icinga_users.each |$username, $user| {
    icinga2::object::user { "${username}":
      enable_notifications => $enable_notifications,
      types                => $types,
      states               => $states,
      groups               => $groups,
      email                => $user[email],
    }

    $htpasswdmd5hash  = $user[htpasswdmd5hash]

    if defined('$htpasswdmd5hash') {
      $htpasswd_command = "/bin/echo ${username}:${htpasswdmd5hash} >> /etc/icinga2-classicui/htpasswd.users"
      exec { "add_htpasswd_${username}":
        command => $htpasswd_command,
        unless  => "/bin/cat /etc/icinga2-classicui/htpasswd.users | /bin/grep '${username}'"
      }
    }
  }

  #Collect all @@icinga2::object::host resources from PuppetDB that were exported by other machines:
  Icinga2::Object::Host <<| |>> { }
  Icinga2::Object::Service <<| |>> { }
  Icinga2::Object::Notification <<| |>> { }
}
