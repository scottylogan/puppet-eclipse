# install Python Development Tools
class eclipse::pydev(
  $ensure   = present,
  $version  = '3.7.1.201409021729',
  $repo     = 'http://pydev.org/updates',
) {

  include eclipse

  eclipse::feature{ 'org.python.pydev.feature':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
