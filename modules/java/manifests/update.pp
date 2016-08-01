class java::update {

  # update the apt keystore
  exec { 'apt-key-update':
    command     => 'apt-key update',
    onlyif      => "/usr/bin/test -f ${java::webupd8src}",
    path        => '/usr/bin/:/bin/',
    subscribe   => File["${java::webupd8src}"],
    refreshonly => true;
  }
  # update apt sources
  exec { 'apt-update-oracle':
    command     => 'apt-get update',
    onlyif      => "/usr/bin/test -f ${java::webupd8src}",
    path        => '/usr/bin/:/bin/',
    subscribe   => File["${java::webupd8src}"],
    refreshonly => true;
  }
}