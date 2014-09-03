# install 64 bit eclipse
class eclipse($version='luna', $release='R') {

  $tmp_dir = '/tmp/eclipse'
  $pkg_name = "eclipse-${version}-${release}"
  $dl_url = "http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/${version}/${release}/eclipse-standard-${version}-${release}-macosx-cocoa-x86_64.tar.gz"

  exec { 'eclipse download':
    command => "rm -rf ${tmp_dir} && mkdir -p ${tmp_dir} && curl -o ${tmp_dir}/eclipse.tar.gz \'${dl_url}\'",
    cwd     => '/',
    notify  => Exec['eclipse repack'],
  }

  exec { 'eclipse repack':
    command     => "tar xzf eclipse.tar.gz && mv eclipse ${pkg_name}.app && tar czf ${pkg_name}.tar.gz ${pkg_name}.app",
    cwd         => $tmp_dir,
#    refreshonly => true,
    notify      => Package['eclipse'],
  }

  package { 'eclipse':
    ensure   => installed,
    name     => "eclipse-${version}-${release}",
    source   => "file://${tmp_dir}/eclipse-${version}-${release}.tar.gz",
    alias    => 'eclipse',
    provider => compressed_app,
    notify   => File['/Applications/Eclipse.app'],
  }

  file { '/Applications/Eclipse.app':
    ensure  => link,
    target  => "/Applications/eclipse-${version}-${release}/Eclipse.app",
    notify  => Exec['eclipse cleanup'],
  }

  exec { 'eclipse cleanup':
    command     => "rm -rf ${tmp_dir}",
    cwd         => '/',
    refreshonly => true,
  }

}
