class profile::repositories(
  $entitlement_cert,
  $entitlement_key
) {
  
  class{'env_repo':
    environment      => $environment,
    entitlement_cert => $entitlement_cert,
    entitlement_key  => $entitlement_key
  }

}
