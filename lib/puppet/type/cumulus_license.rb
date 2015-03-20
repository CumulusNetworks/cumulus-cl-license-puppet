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
  end

  newparam(:force) do
    desc 'force installation of license. Default: false'
    defaultto :false
    newvalues(:true, :false)
  end
end
