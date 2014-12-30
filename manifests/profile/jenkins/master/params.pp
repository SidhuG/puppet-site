class site::profile::jenkins::master::params inherits ::site::params {

  case $::osfamily {
    'RedHat': {
      $packages = [
        'rubygem-bundler',
        'ruby-devel',
        'libxml2-devel',
        'htop',
        'strace',
        'ltrace'
      ]
      $jenkins_user = 'jenkins'
      $docker_group = 'docker'
    }
    default: {fail("OS family ${::osfamily} not supported!")}
  }

  $default_plugins = {
    'buildresult-trigger' => { 'version' =>  '0.17' },
    'copyartifact' => { 'version' => '1.32.1' },
    'matrix-project' => { 'version' => '1.4' },
    'scm-api' => { 'version' => '0.2' },
    'credentials' => { 'version' => '1.18' },
    'mailer' => { 'version' => '1.11' },
    'parameterized-trigger' => { 'version' => '2.4' },
    'ssh-credentials' => { 'version' => '1.10' },
    'git-client' => { 'version' => '1.12.0' },
    'token-macro' => { 'version' => '1.10' },
    'git' => { 'version' => '2.3.1' },
    'ansicolor' => { 'version' => '0.4.0' },
    'build-failure-analyzer' => { 'version' => '1.10.3' },
    'build-monitor-plugin' => { 'version' => '1.6+build.132' },
    'buildgraph-view' => { 'version' => '1.1.1' },
    'build-flow-plugin' => { 'version' => '0.17' },
    'greenballs' => { 'version' => '1.14' },
    'workflow-aggregator' => { 'version' => '1.0' }
  }

}
