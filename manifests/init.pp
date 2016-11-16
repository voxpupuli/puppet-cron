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
#     Default: see params.pp
#
#   service_name - Can be set to define a different cron service name.
#     Default: see params.pp
#
#   manage_service - Defines if puppet should manage the service.
#     Default: true
#
#   service_enable - Defines if the service should be enabled at boot.
#     Default: true

#   service_ensure - Defines if the service should be running.
#     Default: running
#
# Sample Usage:
#   include 'cron'
# or:
#   class { 'cron':
#     manage_package => false,
#   }
#
class cron (
  $manage_package = true,
  $manage_service = true,
  $service_ensure = 'running',
  $service_enable = true,
  $service_name   = $::cron::params::service_name,
  $package_ensure = 'installed',
  $package_name   = $::cron::params::package_name,
) inherits cron::params {

  validate_bool($manage_package, $manage_service, $service_enable)

  include ::cron::install
  include ::cron::service

  anchor { 'cron::start': }
  -> Class['cron::install']
  -> Class['cron::service']
  -> anchor { 'cron::end': }

  # Create jobs from hiera
  $cron_job = hiera_hash('cron::job', undef)
  if $cron_job {
    create_resources('cron::job',$cron_job)
  }

  $cron_job_multiple = hiera_hash('cron::job::multiple', undef)
  if $cron_job_multiple {
    create_resources('cron::job::multiple', $cron_job_multiple)
  }

  $cron_job_hourly = hiera_hash('cron::hourly', undef)
  if $cron_job_hourly {
    create_resources('cron::hourly', $cron_job_hourly)
  }

  $cron_job_daily = hiera_hash('cron::daily', undef)
  if $cron_job_daily {
    create_resources('cron::daily', $cron_job_daily)
  }

  $cron_job_weekly = hiera_hash('cron::weekly', undef)
  if $cron_job_weekly {
    create_resources('cron::weekly', $cron_job_weekly)
  }

  $cron_job_monthly = hiera_hash('cron::monthly', undef)
  if $cron_job_monthly {
    create_resources('cron::monthly', $cron_job_monthly)
  }
}
