# install PHP Development Tools
class eclipse::pdt(
  $ensure   = present,
  $version  = '3.3.0.201406110111',
  $repo     = 'http://download.eclipse.org/tools/pdt/updates/3.3',
) {

  include eclipse

  eclipse::feature{ 'org.eclipse.php':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
