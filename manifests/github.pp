# install Github / EGit support
class eclipse::github(
  $ensure = present,
  $eclipse_version = '4.4',
  $feature_version = '3.4.0.201406110918-r',
  $feature_group = 'org.eclipse.mylyn.github.feature.feature.group',
  $feature_repos = 'http://download.eclipse.org/releases/luna',
) {

  $p2 = "/Applications/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director -noSplash"

  $feature_path = "/Applications/${eclipse::pkg_name}.app/features/${feature_group}_${feature_version}"

  if $ensure == 'present' {
    exec { 'eclipse github egit_mylyn install':
      command => "${p2} -repository ${feature_repos} -installIU ${feature_group}/${feature_version}",
      unless  => "test -d ${feature_path}",
      creates => $feature_path,
      require => Package[$eclipse::pkg_name],
    }
  } else {
    exec { 'eclipse github egit_mylyn remove':
      command => "${p2} -uninstallIU ${feature_group}/${feature_version}",
      onlyif  => "test -d ${feature_path}",
      require => Package[$eclipse::pkg_name],
    }
  }
  
}
