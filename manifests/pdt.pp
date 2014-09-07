# install PHP Development Tools
class eclipse::pdt(
  $ensure = present,
  $eclipse_version = '4.4',
  $feature_version = '3.3.0.201406110111',
  $feature_group = 'org.eclipse.php.feature.group',
  $feature_repos = 'http://download.eclipse.org/tools/pdt/updates/3.3,http://download.eclipse.org/releases/luna',
) {

# also org.eclipse.php.mylyn.feature.group=3.3.0.201406110111
# also org.eclipse.php.test.feature.group=3.3.0.201406110111

  $p2 = "/Applications/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director -noSplash"

  if $ensure == 'present' {
    exec { 'eclipse PDT install':
      command => "${p2} -repository ${feature_repos} -installIU ${feature_group}/${feature_version}",
      unless  => "test -d ${feature_path}",
      creates => $feature_path,
      require => File['/Applications/Eclipse.app'],
    }
  } else {
    exec { 'eclipse PDT remove':
      command => "${p2} -uninstallIU ${feature_group}/${feature_version}",
      onlyif  => "test -d ${feature_path}",
      require => File['/Applications/Eclipse.app'],
    }
  }
  
}
