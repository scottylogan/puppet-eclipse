# install Eclipse Color Theme
class eclipse::colortheme(
  $ensure   = present,
  $version  = '0.14.0.201407150859',
  $repo     = 'https://eclipse-color-theme.github.com/update',
) {

  include eclipse

  eclipse::feature{ 'com.github.eclipsecolortheme.feature':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
