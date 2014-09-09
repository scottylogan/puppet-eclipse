# install Force.Com IDE
class eclipse::force(
  $ensure   = present,
  $version  = '31.0.0.201406301722',
  $repo     = 'http://media.developerforce.com/force-ide/eclipse42',
) {

  include eclipse

  eclipse::feature{ 'com.salesforce.ide.feature':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
