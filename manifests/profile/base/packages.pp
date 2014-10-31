class site::profile::base::packages(
  $extra_packages = $::site::profile::base::extra_packages
) {

  validate_hash($extra_packages)

  case $::osfamily {
    'redhat': {
    }

    'debian': {
    }

    default: {fail("OS family ${::osfamily} not supported by this class!")}
  }

  $extra_packages_defaults = {}
  create_resources('package', $extra_packages, $extra_packages_defaults)
}
