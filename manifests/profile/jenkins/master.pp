class site::profile::jenkins::master inherits ::site::params {
  require ::site::profile::jenkins

  include ::jenkins
}
