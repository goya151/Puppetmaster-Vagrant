class java::rep {

  # Ensure the sources list exists
  # See http://stackoverflow.com/a/10463734/428876 for sharing files and configuring a puppet fileserver
  file { "${java::webupd8src}":
    ensure      => 'present',
    content     => "deb http://ppa.launchpad.net/webupd8team/java/ubuntu lucid main\ndeb-src http://ppa.launchpad.net/webupd8team/java/ubuntu lucid main\n";
  }
  # Authorise the webupd8 ppa
  # At the time of writing this key was correct, but check the PPA page on launchpad!
  # https://launchpad.net/~webupd8team/+archive/java
  exec { 'add-webupd8-key':
    command     => '/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886',
    path        => '/usr/bin/:/bin/',
    subscribe   => File["${java::webupd8src}"],
    refreshonly => true;
  }
}

