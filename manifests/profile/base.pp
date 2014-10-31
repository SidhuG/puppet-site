# perhaps all nodes at your site use this as a base?
class site::profile::base(
  $ntp_servers = $::site::params::ntp_servers,
  $hosts = {},
  $extra_repos = hiera_hash('::site::profile::base::extra_repos', {}),
  $extra_packages = hiera_hash('::site::profile::base::extra_packages', {})
) {

  notice("extra_packages: ${extra_packages}")

  validate_array($ntp_servers)
  validate_hash($hosts, $extra_packages, $extra_repos)

  require ::site::profile

  class { '::site::profile::base::repos': } ->
  class { '::site::profile::base::packages': } ->
  Class ['::site::profile::base']

  class { '::ntp': servers => $ntp_servers, }

  # create some default host entries
  $hosts_defaults = { 'ensure' => present }
  create_resources('host', $hosts, $hosts_defaults)
}
