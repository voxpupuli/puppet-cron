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
      $package_name     = 'virtual/cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_file     = undef
    }
    'Ubuntu': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_file     = undef
    }
    'Debian': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_file     = undef
    }
    'SLES': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_file     = undef
    }
    default: {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_file     = undef
    }
  }
}
