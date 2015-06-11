define site::profile::jenkins::master::pipeline(
  $type,
  $repo_uri,
  $custom_template = undef
) {

  unless $caller_module_name == $module_name {
    fail("Cannot call private define from ${caller_module_name}!")
  }

  validate_re($repo_uri, '^.+$')
  validate_re($type, '^(puppetmodule)$')
  if $custom_template { validate_absolute_path($custom_template) }

  if $custom_template {
    $config = template($custom_template)
  } else {
    $config = template("${module_name}/profile/jenkins/master/pipeline/${type}.yaml.erb")
  }

  ::jenkins_job_builder::job { $name: job_yaml => $config, }
}
