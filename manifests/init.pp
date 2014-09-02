# install 64 bit eclipse
class eclipse($version='luna', $release='R') {

  include java

  package { 'eclipse':
    ensure   => installed,
    provider => 'compressed_app',
    source   => "http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/${version}/${release}/eclipse-standard-${version}-${release}-macosx-cocoa-x86_64.tar.gz"
  }
  
  file { '/Applications/Eclipse.app':
    ensure => 'link',
    target => '/Applications/eclipse/Eclipse.app',
    require => Package['eclipse']
  }

}
