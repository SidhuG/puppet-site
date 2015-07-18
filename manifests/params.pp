class site::params {
  case $osfamily {
    'redhat','debian': {}
    default: { fail("Operating system ${::operatingsystem} ${operatingsystemrelease} not supported!") }
  }
}
