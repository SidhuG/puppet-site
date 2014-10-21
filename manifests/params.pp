class site::params {
  case $::osfamily {
    default: { $ntp_servers = ['pool.ntp.org'] }
#    default: {fail("OS family ${::osfamily} not supported by this module!")}
  }
}
