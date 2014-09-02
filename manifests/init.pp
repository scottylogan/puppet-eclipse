# install 64 bit eclipse
class eclipse($version='luna', $release='R') {

  file { 'eclipse tarball':
    ensure  => 'file',
    path    => "/opt/boxen/eclipse/eclipse-${version}-${release}.tar.gz",
    source  => "http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/${version}/${release}/eclipse-standard-${version}-${release}-macosx-cocoa-x86_64.tar.gz",
    require => Package['java'],
    notify  => Exec['eclipse unpack and rename'],
  }

  exec { 'eclipse unpack and rename':
    command     => "gtar xf eclipse.tar.gz && mv eclipse eclipse-${version}-${release}",
    cwd         => '/opt/boxen/eclipse',
    refreshonly => true,
    notify      => File['/Applications/Eclipse.app'],
  }

  file { '/Applications/Eclipse.app':
    ensure  => 'link',
    target  => "/opt/boxen/eclipse/eclipse-${version}-${release}/Eclipse.app",
    notify  => Exec['eclipse jvmcapabilities fixup'],
  }

  exec { 'eclipse jvmcapabilities fixup':
    command     => 'for pl in /Library/Java/JavaVirtualMachines/jdk1.7*.jdk/Contents/Info.plist; do plutil -replace JavaVM.JVMCapabilities -json \'["CommandLine","BundledApp","JNI"]\' $pl; done',
    refreshonly => true,
    notify      => Exec['eclipse jdk missing symlink'],
  }

  exec { 'eclipse jdk missing symlink':
    command     => 'for jdk in /Library/Java/JavaVirtualMachines/jdk1.7*.jdk/Contents/Home; do mkdir -p $jdk/bundle/Libraries && ln -s $jdk/jre/lib/server/libjvm.dylib $jdk/bundle/Libraries/libserver.dylib; done',
    refreshonly => true,
  }

}
