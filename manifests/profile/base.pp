class site::profile::base(
  $configure_firewall = false,
) inherits ::site::params {

  require ::ntp
  require ::site::profile

  validate_bool($configure_firewall)
  unless ! $configure_firewall { require ::firewall }

  unless 'redhat' != $::osfamily { require ::epel }
}
