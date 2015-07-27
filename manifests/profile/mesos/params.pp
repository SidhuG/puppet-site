class site::profile::mesos::params inherits ::site::params {

  unless 'debian' == $::osfamily {
    fail("OS family ${::osfamily} is not yet supported!")
  }
}
