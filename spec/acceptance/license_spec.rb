require 'spec_helper_acceptance'

describe 'license' do

  context 'installing a v1 license' do

    it 'should work with no errors' do
      pp = <<-EOS
        file { '/tmp/test_v1.lic':
          content => "-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA1\nemail=example@cumulusnetworks.com\naccount=Cumulus Networks\nexpires=1420012800 #2014-12-31\nnum_licenses=100\nNFR=1\n-----BEGIN PGP SIGNATURE-----\nVersion: GnuPG v1.4.12 (GNU/Linux)\nI like ice cream\n-----END PGP SIGNATURE-----",
        }

        # Create a fake cl-license command
        file { '/usr/cumulus/bin/cl-license':
          content => '#!/bin/sh\necho "Rocket Turtle!\nexpires=$(date +%s)\n$0 $@" > /etc/cumulus/.license.txt',
          mode => 0755,
        }

        cumulus_license{ 'test_v1':
          src => '/tmp/test_v1.lic',
          require => [File['/tmp/test_v1.lic'], File['/usr/cumulus/bin/cl-license']],
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/cumulus/.license.txt') do
      it { should be_file }
      its(:content) { should match(/Rocket Turtle!/) }
      its(:content) { should match(%r{/usr/cumulus/bin/cl-license}) }
    end

  end

  context 'force installing a v1 license' do

    it 'should work with no errors' do
      pp = <<-EOS
        cumulus_license{ 'test_v1_force':
          src => '/tmp/test_v1.lic',
          force => true,
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/cumulus/.license.txt') do
      it { should be_file }
      its(:content) { should match(/Rocket Turtle!/) }
      its(:content) { should match(%r{/usr/cumulus/bin/cl-license -i /tmp/test.v1}) }
    end

  end

end
