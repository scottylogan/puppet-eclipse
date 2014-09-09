# install Force.Com IDE
class eclipse::force_com_ide(
  $ensure = present,
  $eclipse_version = '4.4',
  $feature_version = '31.0.0.201406301722',
  $feature_group = 'com.salesforce.ide.feature.feature.group',
  $feature_repos = 'http://media.developerforce.com/force-ide/eclipse42,http://download.eclipse.org/releases/luna',
) {

  $p2 = "/Applications/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director -noSplash"

  $feature_path = "/Applications/${eclipse::pkg_name}.app/features/${feature_group}_${feature_version}"

  if $ensure == 'present' {
    exec { 'eclipse egit_mylyn install':
      command => "${p2} -repository ${feature_repos} -installIU ${feature_group}/${feature_version}",
      unless  => "test -d ${feature_path}",
      creates => $feature_path,
      require => [
        Package[$eclipse::pkg_name],
        File['/Applications/Eclipse.app'],
      ],
    }
  } else {
    exec { 'eclipse egit_mylyn remove':
      command => "${p2} -uninstallIU ${feature_group}/${feature_version}",
      onlyif  => "test -d ${feature_path}",
      require => [
        Package[$eclipse::pkg_name],
        File['/Applications/Eclipse.app'],
      ],
    }
  }
  
}
