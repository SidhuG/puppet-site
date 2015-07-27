class site::profile::mesos::allinone inherits ::site::profile::mesos::params {
  require ::site::profile::mesos

  require ::java
  
  class { '::zookeeper':
    id => '254',
    repo => 'cloudera',
    client_ip => '0.0.0.0',
  } ->

  class { '::mesos':
    repo => 'mesosphere',
    use_syslog => true,
    zookeeper => 'zk://127.0.0.1:2181/mesos',
  } ->

  class { '::mesos::master':
    zookeeper => 'zk://127.0.0.1:2181/mesos',
    options => { quorum => 1, },
    listen_address => '0.0.0.0',
  } ->

  class { '::mesos::slave':
    zookeeper => 'zk://127.0.0.1:2181/mesos',
    listen_address => '0.0.0.0',
    attributes => { 'env' => 'devtest', },
    resources => { 'ports' => '[5000-65535]', },
  } ->

  class { '::marathon':
    zookeeper => 'zk://127.0.0.1:2181/mesos',
  }
}
