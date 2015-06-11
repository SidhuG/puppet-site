require 'spec_helper_acceptance'

describe '::site::profile::puppet::master' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { '::site::profile::puppet::master': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe 'r10k' do
      shell("/opt/puppet/bin/gem list -i r10k")
    end

  end
end
