# cumulus_license

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What cumulus_license affects](#what-cumulus_license-affects)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

This module installs a Cumulus Linux license.

## Module Description

Installs a Cumulus Linux license file on a Cumulus Linux switch.

If a license is already installed, the module will not attempt to overwrite the existing license. You can overwrite the license with the `force` parameter. Using the `force` parameter will remove the idempotent behaviour of the module, so use `force` mode with caution.

When installing a license on a switch, use a non-EULA license. To confirm if you
have a non-EULA license, run `cl-license -i <license path>` and confirm that it
does not prompt you for a EULA.

Version 1.0.x of the module will work with 2.5.2 and lower.
Version 1.1.x and higher will work with 2.5.3 and higher

For more details, read the [Cumulus Linux User Guide](http://docs.cumulusnetworks.com) and search for "License".
Also review the [Cumulus Linux Licensing Knowledge
Base](https://support.cumulusnetworks.com/hc/en-us/sections/200507688)

## Setup

### What cumulus_license affects

This module uses the Cumulus Linux `cl-license` command to manage the license.

To activate a license for the first time, the switchd service must be restarted.

**NOTE**:
Restarting the `switchd` daemon is disruptive.

## Usage

Install a license file if one is not already installed:

```
node default {
   cumulus_license { 'example':
	     src => 'http://example.com/cumulus.lic',
	  notify => Service['switchd']
	}
}
```

## Reference

###cl_license

#### Parameters

   `src`: This is the URL to the license file location. It can be a local path like `/root/new.lic` or a http or https URL. It does not support a `puppet:///` url.

   `force`: Installs the license even though one exists on the switch.
## Limitations

This module only works on Cumulus Linux.

This module does not overwrite an existing license. Use the `force` keyword to perform a license renewal.

`puppet resource cumulus_license` doesn't work. This feature will be implemented in a later version.

## Development

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.


![Cumulus icon](http://cumulusnetworks.com/static/cumulus/img/logo_2014.png)

## Cumulus Linux

Cumulus Linux is a software distribution that runs on top of industry standard networking hardware. It enables the latest Linux applications and automation tools on networking gear while delivering new levels of innovation and ﬂexibility to the data center.

For further details, please see [cumulusnetworks.com](http://www.cumulusnetworks.com).
