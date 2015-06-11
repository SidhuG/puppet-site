class site::profile::puppet::master(
  $enable_r10k = true,
) inherits ::site::params {

  validate_bool($enable_r10k)

  require ::site::profile::base

  unless false == $enable_r10k { require ::r10k }
}
