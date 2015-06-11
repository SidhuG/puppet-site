require 'spec_helper'

describe '::site::profile::puppet::master' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|

      case facts[:operatingsystem]
      when 'Ubuntu'
      end

      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "::site::profile::puppet::master class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('site::profile::base') }
          it { is_expected.to contain_class('r10k') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'site class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
