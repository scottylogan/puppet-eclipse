# install Spring Tool Suite
class eclipse::sts(
  $ensure = present,
  $eclipse_version = '4.4',
  $feature_version = '3.6.1.201408250818-RELEASE-e44',
  $feature_group = 'org.springsource.sts.package.feature.group',
  $feature_repos = "http://dist.springsource.com/release/TOOLS/update/e4.4,http://download.eclipse.org/releases/luna,http://update.atlassian.com/atlassian-eclipse-plugin/rest/e3.7,http://download.eclipse.org/tools/orbit/downloads/drops/I20140701152614/repository",
) {

  $p2 = "/Applications/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director -noSplash"
  
  $feature_path = "/Applications/${eclipse::pkg_name}.app/features/${feature_group}_${feature_version}"

  if $ensure == 'present' {
    exec { 'eclipse sts install':
      command => "${p2} -repository ${feature_repos} -installIU ${feature_group}/${feature_version}",
      unless  => "test -d ${feature_path}",
      creates => $feature_path,
      require => File['/Applications/Eclipse.app'],
    }
  } else {
    exec { 'eclipse sts remove':
      command => "${p2} -uninstallIU ${feature_group}/${feature_version}",
      onlyif  => "test -d ${feature_path}",
      require => File['/Applications/Eclipse.app'],
    }
  }
  
}
