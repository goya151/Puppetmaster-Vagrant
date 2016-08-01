   
   This module provide installation of oracle-java via a PPA 'webupd8team/java'

The PPA supports Ubuntu 15.04, 14.10, 14.04 and 12.04 and switching between Oracle Java 8, Java 7 and Java 6.

General using:
```
  include java

  package { "oracle-java8-installer":
    ensure  => installed,
    require => Exec['apt-update-oracle'];
  }
```

Full manual you could find by the link:
http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html
