class profile::ntp {

  $ntp_packages = ['ntp', 'ntpdate']
  package { $ntp_packages:
    ensure => latest,
  }

  service { 'ntpd' :
    ensure  => running,
    require => Package[$ntp_packages],
  }

  file { '/etc/ntp.conf':
    ensure  => 'present',
    content => template("${module_name}/ntp/ntp_config.erb"),
    require => Package[$ntp_packages],
    notify  => Service['ntpd'],
  }
  
  file { '/etc/localtime':
    ensure => 'link',
    target => '/usr/share/zoneinfo/Europe/Berlin',
  }
}
