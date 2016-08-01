class set_locales {

  file { 'set_locales':
    ensure => file,
    path   => '/tmp/locales.sh',
    source => 'puppet:///modules/set_locales/locales.sh',
    owner  => root,
    group  => root,
    mode   => '0744',
  }

  exec { 'set_locales':
    command => '/tmp/locales.sh',
    unless  => '/bin/grep -c "LC" /etc/environment',
    path    => '/bin/sh',
    require => File['set_locales'],
    user    => 'root'
  }
}