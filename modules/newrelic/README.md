Module installing newrelic agent into JBoss work folder.

By default:
```
  $path_server       = '/usr/local/jboss'                        # Location for JBoss server
  $agent_archive     = 'newrelic-java-3.15.0.zip'                # Name of archive which contain newrelic installation
  $jboss_app_name    = "${fqdn}"                                 # App Name is hostname of node
  $license_key       = '542b7527b76c1f728fe73ed790c0d9a958728f02 # License key from account
```


If you would like to change this values, you could use hiera:
```
newrelic::agent_archive: 'newrelic-java-3.15.0.zip'
newrelic::jboss_app_name: "${fqdn}"
newrelic::license_key: '542b7527b76c1f728fe73ed790c0d9a958728f02'
```
