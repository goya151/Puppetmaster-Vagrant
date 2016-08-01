#
# Installing java from 'webupd8team'
# Available from the ppa:
# oracle-java6-installer, oracle-java7-installer, oracle-java8-installer
#
class java (
  $webupd8src = $java::params::webupd8src

) inherits java::params {

  include java::rep

  include java::update

  include java::license

}