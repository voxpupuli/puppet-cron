require 'spec_helper'

describe 'cron::service' do
  let(:pre_condition) do
    "include ::cron"
  end

  context 'default' do
    let :facts do
      {
        :operatingsystem           => 'Unsupported',
      }
    end
    it do
      should contain_service( 'cron' ).with(
        'ensure' => 'running',
        'name' => 'cron',
        'enable' => 'true'
      )
    end
  end

  context 'CentOS 5' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'CentOS',
        :operatingsystemmajrelease => '5',
      }
    end
    it { should contain_service( 'crond' ).with(
      'name' => 'crond'
      )
    }
  end

  context 'CentOS 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'CentOS',
        :operatingsystemmajrelease => '6',
      }
    end
    it { should contain_service( 'crond' ).with(
      'name' => 'crond'
      )
    }
  end

  context 'Gentoo' do
    let :facts do
      {
        :operatingsystem           => 'Gentoo',
      }
    end
    it { should contain_service( 'cron' ).with(
      'name' => 'cron'
      )
    }
  end

  context 'Ubuntu' do
    let :facts do
      {
        :operatingsystem           => 'Ubuntu',
      }
    end
    it { should contain_service( 'cron' ).with(
      'name' => 'cron'
      )
    }
  end

  context 'Debian' do
    let :facts do
      {
        :operatingsystem           => 'Debian',
      }
    end
    it { should contain_service( 'cron' ).with(
      'name' => 'cron'
      )
    }
  end
end
