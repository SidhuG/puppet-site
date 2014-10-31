class site::profile::puppet::master::params inherits ::site::params {
  $directory_environments_path = "${::settings::confdir}/environments"
  $hiera_config = "${::settings::confdir}/hiera.yaml"

  if $::pe_version {
    $service_name = 'pe-httpd'
  } else {
    $service_name = 'puppet'
  }
}
