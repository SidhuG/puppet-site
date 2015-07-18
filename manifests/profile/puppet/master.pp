class site::profile::puppet::master(
  $r10k_control_repo_server = undef,
  $r10k_control_repo_server_hostkey = undef,
  $r10k_control_repo_username = undef,
  $r10k_control_repo_path = undef,
  $r10k_control_repo_private_key = undef,
  $install_r10k = false
) inherits ::site::params {

 validate_bool($install_r10k)

  require ::site::profile::base

  # r10k not longer requires the git package but its still nice
  # to have available
  require ::git

  if $install_r10k { 
    multi_validate_re($r10k_control_repo_server, $r10k_control_repo_username, '^.+$')
    multi_validate_re($r10k_control_repo_server_hostkey, '^.+$')
    validate_absolute_path($r10k_control_repo_path)
    validate_re($r10k_control_repo_private_key, '^-----BEGIN.+-----$')
 
    class { '::r10k':
      remote => "ssh://git@${r10k_control_repo_server}${r10k_control_repo_path}",
    }

    File { owner => 'root', group => 'root', }

    ensure_resource('file', '/root/.ssh', { 'ensure' => 'directory', 'mode' => '0700', })
   
    file { '/root/.ssh/config':
      ensure => file,
      mode => '0644',
      content => template("${module_name}/profile/puppet/master/ssh_config.erb"),
    }

    file { "/root/.ssh/r10k-${r10k_control_repo_username}.key":
      ensure => file,
      mode => '0700',
      content => $r10k_control_repo_private_key,
    }

    sshkey { $r10k_control_repo_server:
      ensure => present,
      type => rsa,
      key => $r10k_control_repo_server_hostkey,
    }
  }

  file { 'hiera router config':
    ensure => link,
    path => '/etc/puppetlabs/puppet/hiera.yaml',
    target => '/etc/puppetlabs/puppet/environments/production/hiera.yaml',
    notify => Service['pe-puppetserver'],
  }
}
