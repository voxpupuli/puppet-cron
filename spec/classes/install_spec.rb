require 'spec_helper'

describe 'cron::install' do
  context 'default' do
    let :facts do
      {
        :operatingsystem           => 'Unsupported',
      }
    end
    it do
      should contain_package( 'cron' ).with( 'ensure' => 'installed', 'name' => 'cron' )
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
    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
      'name' => 'vixie-cron'
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
    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
      'name' => 'cronie'
      )
    }
  end

  context 'Gentoo' do
    let :facts do
      {
        :operatingsystem           => 'Gentoo',
      }
    end
    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
      'name' => 'virtual/cron'
      )
    }
  end

  context 'Ubuntu' do
    let :facts do
      {
        :operatingsystem           => 'Ubuntu',
      }
    end
    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
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
    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
      'name' => 'cron'
      )
    }
  end

end

