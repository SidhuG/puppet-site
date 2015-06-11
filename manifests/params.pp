class site::params {
  unless 'ubuntu' == $::operatingsystem and '14.04' == $::operatingsystemrelease {
    fail("Operating system ${::operatingsystem} ${operatingsystemrelease} not supported!")
  }
}
