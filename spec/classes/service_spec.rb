# frozen_string_literal: true

require 'spec_helper'

describe 'cron::service' do
  let(:pre_condition) do
    'include cron'
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      context 'default' do
        it { is_expected.to contain_class('cron::service') }
        it { is_expected.to contain_class('cron::install') }
        it { is_expected.to contain_class('cron') }
        it { is_expected.to contain_package('cron') }
        it { is_expected.to compile.with_all_deps }
      end

      context 'CentOS 6', if: os_facts[:os]['family'] == 'RedHat' do
        it {
          is_expected.to contain_service('crond').with(
            'name' => 'crond'
          )
        }
      end

      context 'Gentoo', if: os_facts[:os]['name'] == 'Gentoo' do
        it {
          is_expected.to contain_service('cron').with(
            'name' => 'cron'
          )
        }
      end

      context 'Debian', if: os_facts[:os]['family'] == 'Debian' do
        it {
          is_expected.to contain_service('cron').with(
            'name' => 'cron',
            'ensure' => 'running',
            'enable' => 'true'
          )
        }
      end
    end
  end
end
