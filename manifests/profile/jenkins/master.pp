class site::profile::jenkins::master inherits ::site::params {
  require ::site::profile::jenkins

  class { '::jenkins': configure_firewall => true, }
}
