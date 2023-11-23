# frozen_string_literal: true

require 'spec_helper'

describe 'cron::install' do
  let(:pre_condition) do
    'include cron'
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('cron') }
      it { is_expected.to contain_class('cron::service') }

      context 'RedHat', if: os_facts[:os]['family'] == 'RedHat' do
        it { is_expected.to contain_package('cron').with('ensure' => 'installed', 'name' => 'cronie') }
      end

      context 'Gentoo', if: os_facts[:os]['name'] == 'Gentoo' do
        it { is_expected.to contain_class('cron::install') }

        it { is_expected.to contain_package('cron').with('name' => 'virtual/cron') }
      end

      context 'Debian', if: os_facts[:os]['family'] == 'Debian' do
        it { is_expected.to contain_class('cron::install') }

        it { is_expected.to contain_package('cron').with('name' => 'cron') }
      end
    end
  end
end
