# install Geppetto (Puppet) Development Tools
class eclipse::geppetto(
  $ensure   = present,
  $version  = '4.2.0.v20140725-1640',
  $repo     = 'https://geppetto-updates.puppetlabs.com/4.x',
) {

  include eclipse

  eclipse::feature{ 'com.puppetlabs.geppetto':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
