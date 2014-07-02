# perhaps all nodes at your site use this as a base?

class site::profile::base(
  $ntp_servers = $::site::params::ntp_servers,
  $hosts = {}
) inherits ::site::params {

  validate_array($ntp_servers)
  validate_hash($hosts)

  require ::site::profile

  class { '::ntp': servers => $ntp_servers, }

  # create some default host entries
  $hosts_defaults = { 'ensure' => present }
  create_resources('host', $hosts, $hosts_defaults)

  notify { '::site::profile::base': }
}
