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
      $cronjob_dir      = '/etc/cron.d/jobs'
      $cronjob_file     = ''
    }
    'Ubuntu': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_dir      = '/etc/cron.d/jobs'
      $cronjob_file     = ''
    }
    'Debian': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_dir      = '/etc/cron.d/jobs'
      $cronjob_file     = ''
    }
    'SLES': {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_dir      = '/etc/cron.d/jobs'
      $cronjob_file     = ''
    }
    default: {
      $package_name     = 'cron'
      $service_name     = 'cron'
      $cronjob_contents = undef
      $cronjob_dir      = '/etc/cron.d/jobs'
      $cronjob_file     = ''
    }
  }
}
