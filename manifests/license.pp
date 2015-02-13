# install the license
define cumulus_license::license(
  $src = '',
  $force = False
) {
  case $::operatingsystem {
    Debian : { $supported = true }
    default: { fail("The ${module_name} module is not supported by ${::operatingsystem} based systems") }
  }

  unless license_exists() {
    exec { 'install_license':
      command => "/usr/cumulus/bin/cl-license -i ${src}",
      path    => '/usr/sbin:/usr/bin:/sbin:/bin:/usr/cumulus/bin'
    }
  }
}
