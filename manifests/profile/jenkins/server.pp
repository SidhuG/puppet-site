class site::profile::jenkins::server inherits ::site::params {
  require ::site::profile::jenkins
  include ::jenkins
}
