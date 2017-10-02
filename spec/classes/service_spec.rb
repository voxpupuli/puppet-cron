require 'spec_helper'

describe 'cron::service' do
  let(:pre_condition) do
    "include ::cron"
  end

  context 'default' do
    let :facts do
      {
        :os => { :family => 'Unsupported' }
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
        :os => {
          :family => 'RedHat',
          :release => { :major => '5' }
        }
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
        :os => {
          :family => 'RedHat',
          :release => { :major => '6' }
        }
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
        :os => { :family => 'Gentoo' }
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
        :os => { :family => 'Debian' }
      }
    end
    it { should contain_service( 'cron' ).with(
      'name' => 'cron'
      )
    }
  end
end
