Puppet::Type.newtype(:cumulus_license) do
  desc 'Installs Cumulus Linux license'

  # some puppet voodoo. looked at the source code
  # to see if there was a way to default the :ensure property
  # to present..defining this does the trick.purpose..unknown?
  def managed?
    true
  end

  ensurable

  newparam(:name) do
    desc 'used as the title for the module instantiation'
    # without it you get the error:
    # "No set of title patterns matched the title 'license'"
  end

  newparam(:src) do
    desc 'new license file location'
    munge do |value|
      # support using puppet:/// syntax.
      # takes content from puppet server and copies it to /tmp directory
      # then passes file name to provider code to execute cl-license.
      if value.start_with?('puppet:')
        lic_content =
          Puppet::FileServing::Content.indirection.find(value).content
        temp_file_loc = "/tmp/#{Facter.value('hostname')}.lic"
        temp_file = File.new(temp_file_loc, 'w')
        temp_file.puts(lic_content)
        temp_file.close
        temp_file_loc
      else
        value
      end
    end
  end

  newparam(:force) do
    desc 'force installation of license. Default: false'
    defaultto :false
    newvalues(:true, :false)
  end
end
