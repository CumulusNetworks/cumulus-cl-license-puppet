# cumulus_license

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What cumulus_license affects](#what-cumulus_license  -affects)
    * [Beginning with cumulus_license](#beginning-with-cumulus_license)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs a Cumulus Linux license

## Module Description

The cumulus_license module  is responsible for installing a Cumulus Linux license.
For more details, visit [Cumulus Linux User Guide](http://docs.cumulusnetworks.com) and search for
"License"

## Setup

### What cumulus_license affects

* This module uses the Cumulus Linux `cl-license` command to manage the license.
* When installing a new license, switchd must be restarted.
> **NOTE**: restarting the `switchd` daemon is disruptive


### Beginning with cumulus_license

This module does not use any default parameters.

## Usage

The module currently supports one defined type, `cumulus_license::license`
```
node default {
  cumulus_license { 'license':
    src => "http://10.1.1.1/license"
  }
}

```

## Reference

### Classes
  * `cumulus_ports`: Main class. It is empty

### Custom Type
  * `cumulus_license`:  installs a Cumulus Linux license if one does not exist. The options provided by this defined type are:
    * `src`: this is the url to the license file location. It can be a local path like '/root/license' or a http or https url
    * `force`: installs the license even though one exists on the switch.

## Limitations

This module only works on Cumulus Linux.

The module, currently, does not do any error
checking. Ensure all config is thoroughly tested or the switch can
behave in unpredictable ways.

This module does not overwrite an expired license. Use the force keyword to
install a renewed license. This feature will be added in a future release.

## Development

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.


![Cumulus icon](http://cumulusnetworks.com/static/cumulus/img/logo_2014.png)

### Cumulus Linux

Cumulus Linux is a software distribution that runs on top of industry standard
networking hardware. It enables the latest Linux applications and automation
tools on networking gear while delivering new levels of innovation and
ﬂexibility to the data center.

For further details please see:
[cumulusnetworks.com](http://www.cumulusnetworks.com)

## CONTRIBUTORS

- Stanley Karunditu (@skamithik)
