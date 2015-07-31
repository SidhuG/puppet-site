class site::profile::endpoint::params inherits ::site::params {
  unless 'redhat' == $::osfamily {
    fail("OS family ${::osfamily} not supported by this profile!")
  }
}
