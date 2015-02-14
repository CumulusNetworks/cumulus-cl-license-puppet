# install the license
define cumulus_license::license(
  $src = '',
  $force = False
) {
  case $::operatingsystem {
    CumulusLinux : { $supported = true }
    default: { fail("The ${module_name} module is not supported by ${::operatingsystem} based systems") }
  }

  if file('/etc/cumulus/.license.txt', '/dev/null') == '' {
    exec { 'install_license':
      command => "cl-license -i ${src}",
      path    => '/usr/sbin:/usr/bin:/sbin:/bin:/usr/cumulus/bin'
    }
  }
}
