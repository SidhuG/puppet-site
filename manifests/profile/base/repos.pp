class site::profile::base::repos(
  $enable_epel = true,
  $extra_repos = $::site::profile::base::extra_repos
) {

  validate_hash($extra_repos)

  case $::osfamily {
    'redhat': {
      $repo_type = 'yumrepo'
      if $enable_epel {
        require ::epel
        Package <||> { require +> Class['::epel'], }
      }
    }

    'debian': {
      $repo_type = 'apt::source'
      require ::apt
      Package <||> { require +> Class['::apt'], }
    }

    default: {fail("OS family ${::osfamily} not supported by this class!")}
  }

  $extra_repos_defaults = {}
  create_resources($repo_type, $extra_repos, $extra_repos_defaults)
}
