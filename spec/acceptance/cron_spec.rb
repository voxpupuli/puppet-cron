# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron' do
  context 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        'include cron'
      end
    end
  end

  context 'with a cron' do
    it_behaves_like 'an idempotent resource' do
      pp = <<-PUPPET
      include cron
      cron::job { 'mysqlbackup':
        minute      => '40',
        hour        => '2',
        date        => '*',
        month       => '*',
        weekday     => '*',
        user        => 'root',
        command     => 'mysqldump -u root mydb',
        environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
        description => 'Mysql backup',
      }
      PUPPET
      let(:manifest) do
        pp
      end
      describe file('/etc/cron.d/mysqlbackup') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
      end
    end
  end

  context 'with a more complicated cron' do
    it_behaves_like 'an idempotent resource' do
      pp = <<-PUPPET
      include cron
      cron::job { 'mysqlbackup2':
        minute      => '7,14,20',
        hour        => '0-6,8-13,15-19,21-23',
        date        => '*',
        month       => '*',
        weekday     => '*',
        user        => 'root',
        command     => 'mysqldump -u root mydb',
        environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
        description => 'Mysql backup',
      }
      cron::job { 'mysqlbackup3':
        minute      => '7,14,20',
        hour        => '7,14,20',
        date        => '*',
        month       => '*',
        weekday     => '*',
        user        => 'root',
        command     => 'mysqldump -u root mydb',
        environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
        description => 'Mysql backup',
      }
      cron::job { 'mysqlbackup4':
        minute      => '7,14,20',
        hour        => '1-2,3-6/2,12',
        date        => '*',
        month       => '*',
        weekday     => '*',
        user        => 'root',
        command     => 'mysqldump -u root mydb',
        environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
        description => 'Mysql backup',
      }
      cron::job { 'mysqlbackup5':
        minute      => '7,14,20',
        hour        => '0-6,8-13,15-19,21-23',
        date        => '*',
        month       => '*',
        weekday     => '*',
        user        => 'root',
        command     => 'mysqldump -u root mydb',
        environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
        description => 'Mysql backup',
      }
      PUPPET
      let(:manifest) do
        pp
      end
      # rubocop:disable RSpec/RepeatedExampleGroupBody
      describe file('/etc/cron.d/mysqlbackup2') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
      end

      describe file('/etc/cron.d/mysqlbackup3') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
      end

      describe file('/etc/cron.d/mysqlbackup4') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
      end

      describe file('/etc/cron.d/mysqlbackup5') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
      end
      # rubocop:enable RSpec/RepeatedExampleGroupBody
    end
  end
end
