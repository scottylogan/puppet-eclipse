# install 64 bit eclipse
class eclipse($version='luna', $release='R') {

  $tmp_dir = '/tmp/eclipse'
  $pkg_name = "eclipse-${version}-${release}"
  $dl_url = "http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/${version}/${release}/eclipse-standard-${version}-${release}-macosx-cocoa-x86_64.tar.gz"

  file { $tmp_dir:
    ensure  => directory,
    force   => true,
    purge   => true,
  }

  exec { 'eclipse download':
    command => "curl -qLo eclipse.tar.gz '${dl_url}'",
    cwd     => $tmp_dir,
    require => File[$tmp_dir],
    timeout => 1200,
    notify  => Exec['eclipse repack'],
  }

  exec { 'eclipse repack':
    command     => "tar xzf eclipse.tar.gz && mv eclipse ${pkg_name}.app && tar czf ${pkg_name}.tar.gz ${pkg_name}.app",
    cwd         => $tmp_dir,
    refreshonly => true,
    require     => File[$tmp_dir],
    creates     => "${tmp_dir}/${pkg_name}.tar.gz",
    notify      => Package['eclipse'],
  }

  package { 'eclipse':
    ensure   => installed,
    name     => $pkg_name,
    source   => "file://${tmp_dir}/${pkg_name}.tar.gz",
    alias    => 'eclipse',
    provider => compressed_app,
    require  => File[$tmp_dir],
    notify   => File['/Applications/Eclipse.app'],
  }

  file { '/Applications/Eclipse.app':
    ensure  => link,
    target  => "/Applications/${pkg_name}.app/Eclipse.app",
    require => Package['eclipse'],
    notify  => Exec['eclipse cleanup'],
  }

  exec { 'eclipse cleanup':
    command     => "rm -rf ${tmp_dir}",
    cwd         => '/',
    refreshonly => true,
    require     => File['/Applications/Eclipse.app'],
  }

}
