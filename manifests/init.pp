# Class: cron
#
# This class wraps *cron::install* for ease of use
#
# Parameters:
#   manage_package - Can be set to disable package installation.
#     Set to true to manage it, false to not manage it.
#     Default: true
#
#   package_ensure - Can be set to a package version, 'latest', 'installed' or
#     'present'.
#     Default: installed
#
#   package_name - Can be set to install a different cron package.
#     Default: undef
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include 'cron'
# or:
#   class { 'cron':
#     manage_package => false,
# }
#
class cron (
  $manage_package = true,
  $package_ensure = 'installed',
  $package_name   = undef,
) {

  if $manage_package {
    class { '::cron::install':
      package_ensure => $package_ensure,
      package_name   => $package_name,
    }
  }

  # Create jobs from hiera
  $cron_job=hiera_hash('cron::job', undef)
  if $cron_job {
    create_resources('cron::job',$cron_job)
  }

  $cron_job_multiple=hiera_hash('cron::job::multiple', undef)
  if $cron_job_multiple {
    create_resources('cron::job::multiple',$cron_job_multiple)
  }

  $cron_job_hourly=hiera_hash('cron::hourly', undef)
  if $cron_job_hourly {
    create_resources('cron::hourly',$cron_job_hourly)
  }

  $cron_job_daily=hiera_hash('cron::daily', undef)
  if $cron_job_daily {
    create_resources('cron::daily',$cron_job_daily)
  }

  $cron_job_weekly=hiera_hash('cron::weekly', undef)
  if $cron_job_weekly {
    create_resources('cron::weekly',$cron_job_weekly)
  }

  $cron_job_monthly=hiera_hash('cron::monthly', undef)
  if $cron_job_monthly {
    create_resources('cron::monthly',$cron_job_monthly)
  }

}

