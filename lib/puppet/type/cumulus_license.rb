Puppet::Type.newtype(:cumulus_license) do
  desc "Installs Cumulus Linux license"

  # it cannot be destroyed when it exists and should not be
  ensurable

  newparam(:name) do
    desc "used as the title for the module instantiation"
    # without it you get the error:
    # "No set of title patterns matched the title 'license'"
  end

  newparam(:src) do
    desc "new license file location"
  end

  newparam(:force) do
    desc "force installation of license. Default: false"
    defaultto :false
    newvalues(:true, :false)
  end

end
