require 'spec_helper'

describe 'cron::job::multiple' do
  let( :title )  { 'mysql_backup' }

  context 'multiple job with custom and default values' do
    let( :params ) {{
      :environment => [ 'MAILTO="root"', 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"' ],
      :jobs        => [
        {
          'minute'     => '45',
          'hour'       => '7',
          'date'       => '12',
          'month'      => '7',
          'weekday'    => '*',
          'user'       => 'admin',
          'mode'       => '0640',
          'command'    => 'mysqldump -u root test_db >some_file',
        },
        {
          'command'    => '/bin/true',
        },
      ], 
      :mode        => '0640',
    }}
    let( :cron_timestamp ) { get_timestamp( params ) }

    it do
      should contain_file( "job_#{title}" ).with(
        'owner'   => 'root',
        'mode'    => params[:mode]
      ).with_content(
        /\n#{params[:environment].join('\n')}\n/
      ).with_content(
        /\n#{cron_timestamp}\s+/
      ).with_content(
        /\s+45 7 12 7 \*  admin  mysqldump -u root test_db >some_file\n/
      ).with_content(
        /\s+\* \* \* \* \*  root  \/bin\/true\n/
      )
    end
  end

  context 'multiple job with ensure set to absent' do
    let( :params ) {{
      :ensure  => 'absent',
      :jobs    => [
        {
          'command' => '/bin/true',
        }, {
          'command' => '/bin/false',
        },
      ],
    }}

    it do
      should contain_file( "job_#{title}" ).with( 'ensure' => 'absent' )
    end
  end
end

