require 'spec_helper'

describe 'site' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "site class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('site::params') }
        it { should contain_class('site::install').that_comes_before('site::config') }
        it { should contain_class('site::config') }
        it { should contain_class('site::service').that_subscribes_to('site::config') }

        it { should contain_service('site') }
        it { should contain_package('site').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'site class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('site') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
