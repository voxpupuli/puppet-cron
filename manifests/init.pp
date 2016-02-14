# Class: cron
#
# This class wraps *cron::instalL* for ease of use
#
# Parameters:
#   package_ensure - Can be set to a package version, 'latest', 'installed' or 'present'.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include 'cron'
#   class { 'cron': }
#
class cron (
  $package_ensure = 'installed'
) {

  class { '::cron::install':
    package_ensure => $package_ensure,
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

