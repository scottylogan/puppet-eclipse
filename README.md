[![Build Status](https://travis-ci.org/scottylogan/puppet-eclipse.svg?branch=features)](https://travis-ci.org/scottylogan/puppet-eclipse)

## Usage

```puppet
include eclipse
include eclipse::pdt
```

## Adding More Plugins

Just copy one of the existing plugin classes, like pdt.pp, and change
the title, version and repo attributes.

## Required Puppet Modules

* `boxen`
* `stdlib`

