# frozen_string_literal: true

require 'spec_helper'

describe 'cron' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:os]['family']
      when 'RedHat'
        package_name = 'cronie'
        service_name = 'crond'
      when 'Gentoo'
        package_name = 'virtual/cron'
        service_name = 'cron'
      else
        package_name = 'cron'
        service_name = 'cron'
      end

      context 'default' do
        it { is_expected.to contain_class('cron::install') }
      end

      context 'manage_package => false' do
        let(:params) do
          { manage_package: false,
            package_ensure: 'cron' }
        end

        it { is_expected.to contain_class('cron::install') }
        it { is_expected.not_to contain_package('cron') }
      end

      context 'manage_package => true' do
        let(:params) do
          { manage_package: true,
            package_ensure: 'installed' }
        end

        it { is_expected.to contain_class('cron::install') }
        it { is_expected.to contain_package('cron') }
      end

      context 'package_ensure => absent' do
        let(:params) do
          { manage_package: true,
            package_ensure: 'absent' }
        end

        it { is_expected.to contain_class('cron::install') }

        it {
          is_expected.to contain_package('cron').with(
            'name' => package_name,
            'ensure' => 'absent'
          )
        }
      end

      context 'package_name => sys-process/cronie' do
        let(:params) { { package_name: 'sys-process/cronie' } }

        it { is_expected.to contain_class('cron::install') }

        it {
          is_expected.to contain_package('cron').with(
            'name' => 'sys-process/cronie',
            'ensure' => 'installed'
          )
        }
      end

      context 'manage_service => false' do
        let(:params) { { manage_service: false } }

        it { is_expected.to contain_class('cron::service') }
        it { is_expected.not_to contain_service(service_name) }
      end

      context 'manage_service => true' do
        let(:params) { { manage_service: true } }

        it { is_expected.to contain_class('cron::service') }
        it { is_expected.to contain_service(service_name) }
      end

      context 'service_ensure => stopped and manage_service => true' do
        let(:params) do
          {
            manage_service: true,
            service_ensure: 'stopped'
          }
        end

        it { is_expected.to contain_class('cron::service') }

        it {
          is_expected.to contain_service(service_name).with(
            'name' => service_name,
            'ensure' => 'stopped',
            'enable' => true
          )
        }
      end

      context 'service_ensure => stopped and manage_service =>true and service_enable => false' do
        let(:params) do
          {
            manage_service: true,
            service_ensure: 'stopped',
            service_enable: false
          }
        end

        it { is_expected.to contain_class('cron::service') }

        it {
          is_expected.to contain_service(service_name).with(
            'name' => service_name,
            'ensure' => 'stopped',
            'enable' => false
          )
        }
      end

      context 'manage_crontab => true' do
        let(:params) do
          {
            manage_crontab: true
          }
        end

        it {
          is_expected.to contain_file('/etc/crontab').with(
            'ensure' => 'file',
            'owner' => 'root',
            'group' => '0',
            'mode' => '0644'
          )
        }

        it {
          verify_contents(catalogue, '/etc/crontab',
                          [
                            'SHELL=/bin/bash',
                            'PATH=/sbin:/bin:/usr/sbin:/usr/bin',
                            'MAILTO=root',
                            '# For details see man 4 crontabs'
                          ])
        }

        if facts[:os]['family'] == 'RedHat' && facts[:os]['release']['major'].to_i == 6
          context 'on rhel 6' do
            it {
              verify_contents(catalogue, '/etc/crontab',
                              [
                                'SHELL=/bin/bash',
                                'PATH=/sbin:/bin:/usr/sbin:/usr/bin',
                                'MAILTO=root',
                                'HOME=/',
                                '# For details see man 4 crontabs'
                              ])
            }
          end
        end

        context 'crontab_run_parts defined' do
          let(:params) do
            {
              manage_crontab: true,
              crontab_run_parts: {
                '5min' => { 'user' => 'root', 'minute' => '*/5', 'hour' => '*' },
                '30min' => { 'user' => 'root', 'minute' => '*/30', 'hour' => '*' }
              }
            }
          end

          it {
            verify_contents(catalogue, '/etc/crontab',
                            [
                              '*/5 * * * * root run-parts /etc/cron.5min',
                              '*/30 * * * * root run-parts /etc/cron.30min'
                            ])
          }

          it {
            is_expected.to contain_file('/etc/cron.5min').with(
              'ensure' => 'directory',
              'owner' => 'root',
              'group' => '0',
              'mode' => '0755'
            )
          }

          it {
            is_expected.to contain_file('/etc/cron.30min').with(
              'ensure' => 'directory',
              'owner' => 'root',
              'group' => '0',
              'mode' => '0755'
            )
          }
        end
      end
    end
  end

  context 'merge => deep' do
    let(:params) do
      {
        merge: 'deep',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('cron').with_merge('deep') }
  end
end
