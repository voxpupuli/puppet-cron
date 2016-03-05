require 'spec_helper'

describe 'cron' do
  context 'default' do
    it { should contain_class( 'cron::install' ) }
  end

  context 'manage_package => false' do
    let( :params ) {{ :manage_package => false,
                      :package_ensure => 'cron', }}

    it { is_expected.to_not contain_class( 'cron::install' ) }
    it { is_expected.to_not contain_package( 'cron' ) }
  end

  context 'manage_package => true' do
    let( :params ) {{ :manage_package => true,
                      :package_ensure => 'installed', }}

    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ) }
  end

  context 'package_ensure => absent' do
    let( :params ) {{ :manage_package => true,
                      :package_ensure => 'absent', }}

    it { should contain_class( 'cron::install' ) }
    it { should contain_package( 'cron' ).with(
      'name'   => 'cron',
      'ensure' => 'absent'
      )
    }
  end
end
