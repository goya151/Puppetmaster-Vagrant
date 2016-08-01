#
# Setup PuppetDB.
#

class puppetdb {

  include puppetdb::packages
  include puppetdb::service
  include puppetdb::config
  include puppetdb::postgres

}