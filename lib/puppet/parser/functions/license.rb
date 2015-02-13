module Puppet::Parser::Functions
  newfunction(:license_exists, :type => :rvalue) do |args|
    File.exist?('/etc/cumulus/.license.txt')
  end
end
