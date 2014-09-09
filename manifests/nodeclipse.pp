# install Nodeclipse
class eclipse::nodeclipse(
  $ensure   = present,
  $version  = '0.16.0.201406090411',
  $repo     = 'http://dl.bintray.com/nodeclipse/nodeclipse/0.16/',
) {

  include eclipse

  eclipse::feature{ 'org.nodeclipse':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
