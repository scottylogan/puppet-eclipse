# install Github / EGit support
class eclipse::github(
  $ensure   = present,
  $version  = '3.4.0.201406110918-r',
  $repo     = 'http://download.eclipse.org/releases/luna',
) {

  include eclipse

  eclipse::feature{ 'org.eclipse.mylyn.github.feature':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
