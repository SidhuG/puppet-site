class site::profile::jenkins::master inherits ::site::params {
  require ::site::profile::jenkins

  # puppetlabs/firewall appears to be broken for CentOS7/systemd right now
  class { '::firewall': ensure => stopped, }
  class { '::jenkins': configure_firewall => true, }
}
