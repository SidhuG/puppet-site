class site::profile::puppet::master::params inherits ::site::params {
  $directoryenvironments_path = "${::settings::confdir}/environments"
}
