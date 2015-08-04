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
          content => '#!/bin/sh\necho "Rocket Turtle!"\necho $@ > /etc/cumulus/.license.txt\n',
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
      it { should exist }
    end

  end

end
