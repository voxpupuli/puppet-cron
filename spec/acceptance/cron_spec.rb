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
end
