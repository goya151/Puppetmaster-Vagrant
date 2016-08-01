class pnp4nagios::config inherits pnp4nagios {

  file { '/etc/pnp4nagios/config.php':
    ensure  => file,
    content => template('pnp4nagios/config.php');
  }

  service { ['npcd', 'apache2']:
    ensure  => 'running',
    require => Service['icinga2'];
  }

  file { '/etc/pnp4nagios/npcd.cfg':
    ensure  => file,
    content => template('pnp4nagios/npcd.cfg'),
    notify  => Service['npcd'];
  }

  file { '/etc/pnp4nagios/apache.conf':
    ensure  => file,
    content => template('pnp4nagios/apache.conf');
  } ->
  exec { '/usr/sbin/a2enmod rewrite && service apache2 restart':
    unless  => '/usr/sbin/apachectl -M | /bin/grep -c rewrite'
  } ->
  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure  => 'absent',
    notify  => Service['apache2'];
  } ->
  file { '/etc/apache2/sites-enabled/apache.conf':
    ensure  => 'link',
    target  => '/etc/pnp4nagios/apache.conf',
    owner   => 'nagios',
    group   => 'nagios',
    notify  => Service['apache2'];
  }

  file { '/etc/nagios3/nagios.cfg':
    ensure  => file,
    content => template('pnp4nagios/nagios.cfg'),
    notify  => Service['icinga2'];
  }

  file { '/etc/default/npcd':
    ensure  => file,
    content => template('pnp4nagios/default_npcd'),
    notify  => Service['npcd'];
  }
}