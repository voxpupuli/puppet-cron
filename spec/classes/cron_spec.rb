require 'spec_helper'

describe 'cron' do
  it { should contain_class( 'cron::install' ) }
end

describe 'cron' do
  let( :params ) {{ :manage_package => false,
                    :package_ensure => 'cron', }}

  it { is_expected.to_not contain_class( 'cron::install' ) }
  it { is_expected.to_not contain_package( 'cron' ) }
end

describe 'cron' do
  let( :params ) {{ :manage_package => true,
                    :package_ensure => 'cron', }}

  it { should contain_class( 'cron::install' ) }
  it { should contain_package( 'cron' ) }
end

