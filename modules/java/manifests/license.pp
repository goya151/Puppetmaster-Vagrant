class java::license {

  # set license acceptance with debconf
  # thanks to Gert van Dijk on http://askubuntu.com/a/190674
  exec { 'accept-java-license':
    command     => '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections;/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true | sudo /usr/bin/debconf-set-selections;',
    subscribe   => File["${java::webupd8src}"],
    refreshonly => true;
  }
}