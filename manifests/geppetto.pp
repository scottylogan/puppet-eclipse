# install Geppetto (Puppet) Development Tools
class eclipse::geppetto(
  $ensure = present,
  $eclipse_version = '4.4',
  $feature_version = '4.2.0.v20140725-1640',
  $feature_group = 'com.puppetlabs.geppetto.feature.group',
  $feature_repos = 'https://geppetto-updates.puppetlabs.com/4.x,http://download.eclipse.org/releases/luna',
) {

  $p2 = "/Applications/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director -noSplash"

  if $ensure == 'present' {
    exec { 'eclipse geppetto install':
      command => "${p2} -repository ${feature_repos} -installIU ${feature_group}/${feature_version}",
      unless  => "test -d ${feature_path}",
      creates => $feature_path,
      require => File['/Applications/Eclipse.app'],
    }
  } else {
    exec { 'eclipse geppetto remove':
      command => "${p2} -uninstallIU ${feature_group}/${feature_version}",
      onlyif  => "test -d ${feature_path}",
      require => File['/Applications/Eclipse.app'],
    }
  }
  
}
