# Puppet Cron Module

## Build Status:

  * **master:** [![master branch status](https://secure.travis-ci.org/roman-mueller/rmueller-cron.png?branch=master)](http://travis-ci.org/roman-mueller/rmueller-cron)

## Notes:

This module manages cronjobs by placing a file in /etc/cron.d.  
It is a fork of [torrancew/puppet-cron](https://github.com/torrancew/puppet-cron) which seems to be abandoned.  
It defines the following types:

  * cron::job     - basic job skeleton
  * cron::hourly  - wrapper for hourly jobs
  * cron::daily   - wrapper for daily jobs
  * cron::weekly  - wrapper for weekly jobs
  * cron::monthly - wrapper for monthly jobs

## Installation:

As usual use `puppet module install rmueller-cron` to install it.  

This module can optionally install the cron package if needed - simply:

    include cron

## Usage:

*The title of the job (quoted part after the opening '{' ) is completely arbitrary. However, there can only be one cron job by that name.*
The file in `/etc/cron.d/` will be created with the `$title` as the file name.  
Keep that in mind when chosing the name to avoid overwriting exsting system cronjobs and use characters that don't cause problems when used in filenames.

### cron::job

cron::job creates generic jobs in /etc/cron.d.
It allows specifying the following parameters:

  * `ensure`      - optional - defaults to "present"
  * `command`     - required - the command to execute
  * `minute`      - optional - defaults to "\*"
  * `hour`        - optional - defaults to "\*"
  * `date`        - optional - defaults to "\*"
  * `month`       - optional - defaults to "\*"
  * `weekday`     - optional - defaults to "\*"
  * `user`        - optional - defaults to "root"
  * `environment` - optional - defaults to ""
  * `mode`        - optional - defaults to "0644"

Example:
  This would create the file `/etc/cron.d/mysqlbackup` and run the command "mysqldump -u root mydb" as root at 2:40 AM every day:

    cron::job { 'mysqlbackup':
      minute      => '40',
      hour        => '2',
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => 'root',
      command     => 'mysqldump -u root mydb',
      environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"' ];
    }

### cron::hourly

cron::hourly creates jobs in /etc/cron.d that run once per hour.
It allows specifying the following parameters:

  * `ensure`      - optional - defaults to "present"
  * `command`     - required - the command to execute
  * `minute`      - optional - defaults to "0"
  * `user`        - optional - defaults to "root"
  * `environment` - optional - defaults to ""
  * `mode`        - optional - defaults to "0644"

Example:
  This would create the file `/etc/cron.d/mysqlbackup_hourly` and run the command "mysqldump -u root mydb" as root on the 20th minute of every hour:

    cron::hourly { 'mysqlbackup_hourly':
      minute      => '20',
      user        => 'root',
      command     => 'mysqldump -u root mydb',
      environment => "MAILTO=root\nPATH='/usr/bin:/bin'";
    }

### cron::daily

cron::daily creates jobs in /etc/cron.d that run once per day.
It allows specifying the following parameters:

  * `ensure`      - optional - defaults to "present"
  * `command`     - required - the command to execute
  * `minute`      - optional - defaults to "0"
  * `hour`        - optional - defaults to "0"
  * `user`        - optional - defaults to "root"
  * `environment` - optional - defaults to ""
  * `mode`        - optional - defaults to "0644"

Example:
  This would create the file `/etc/cron.d/mysqlbackup_daily` and run the command "mysqldump -u root mydb" as root at 2:40 AM every day, like the above generic example:

    cron::daily { 'mysqlbackup_daily':
      minute  => '40',
      hour    => '2',
      user    => 'root',
      command => 'mysqldump -u root mydb';
    }

### cron::weekly

cron::weekly creates jobs in /etc/cron.d that run once per week.
It allows specifying the following parameters:

  * `ensure`      - optional - defaults to "present"
  * `command`     - required - the command to execute
  * `minute`      - optional - defaults to "0"
  * `hour`        - optional - defaults to "0"
  * `weekday`     - optional - defaults to "0"
  * `user`        - optional - defaults to "root"
  * `environment` - optional - defaults to ""
  * `mode`        - optional - defaults to "0644"

Example:
  This would create the file `/etc/cron.d/mysqlbackup_weekly` and run the command "mysqldump -u root mydb" as root at 4:40 AM every Sunday, like the above generic example:

    cron::weekly { 'mysqlbackup_weekly':
      minute  => '40',
      hour    => '4',
      weekday => '0',
      user    => 'root',
      command => 'mysqldump -u root mydb';
    }

### cron::monthly

cron::monthly creates jobs in /etc/cron.d that run once per month.
It allows specifying the following parameters:

  * `ensure`      - optional - defaults to "present"
  * `command`     - required - the command to execute
  * `minute`      - optional - defaults to "0"
  * `hour`        - optional - defaults to "0"
  * `date`        - optional - defaults to "1"
  * `user`        - optional - defaults to "root"
  * `environment` - optional - defaults to ""
  * `mode`        - optional - defaults to "0644"

Example:
  This would create the file `/etc/cron.d/mysqlbackup_monthly` and run the command "mysqldump -u root mydb" as root at 3:40 AM the 1st of every month, like the above generic example:

    cron::monthly { 'mysqlbackup_monthly':
      minute  => '40',
      hour    => '3',
      date    => '1',
      user    => 'root',
      command => 'mysqldump -u root mydb';
    }

## Contributors:

  * Kevin Goess (@kgoess)               - Environment variable support + fixes
  * Andy Shinn (@andyshinn)             - RedHat derivatives package name fix 
  * Chris Weyl (@RsrchBoy)              - Fixed Puppet 3.2 deprecation warnings
  * Mathew Archibald (@mattyindustries) - Fixed file ownership issues
  * The Community                       - Continued improvement of this module via bugs and patches

