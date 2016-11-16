# == Class cron::params
#
# This class stores parameters for cron
class cron::params {
  case $::operatingsystem {
    /^(RedHat|CentOS|Amazon|OracleLinux|Scientific)/: {
      if versioncmp($::operatingsystemmajrelease, '5') <= 0 {
        $package_name = 'vixie-cron'
      } else {
        $package_name = 'cronie'
      }
      $service_name = 'crond'
    }
    'Gentoo': {
      $package_name = 'virtual/cron'
      $service_name = 'cron'
    }
    'Ubuntu': {
      $package_name = 'cron'
      $service_name = 'cron'
    }
    'Debian': {
      $package_name = 'cron'
      $service_name = 'cron'
    }
    'SLES': {
      $package_name = 'cron'
      $service_name = 'cron'
    }
    default: {
      $package_name = 'cron'
      $service_name = 'cron'
    }
  }
}
