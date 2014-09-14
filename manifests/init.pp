# install 64 bit eclipse
class eclipse(
  $version        = 'luna',
  $release        = 'R',
) {

  $tmp      = '/tmp/eclipse'
  $pkg      = "eclipse-${version}-${release}"
  $repo     = 'http://download.eclipse.org/releases/luna'
  $app      = '/Applications/Eclipse.app'
  $cli      = "${app}/Contents/MacOS/eclipse"
  $features = "/Applications/${pkg}.app/features"
  $p2       = "${cli} -application org.eclipse.equinox.p2.director -noSplash"
  $dl_url   = join([
                'http://www.eclipse.org/downloads/download.php',
                '?r=1',
                '&file=/technology/epp/downloads/release/',
                $version,
                '/',
                $release,
                '/eclipse-standard-',
                $version,
                '-',
                $release,
                '-macosx-cocoa-x86_64.tar.gz'
              ], '')

  file { $tmp:
    ensure  => directory,
    force   => true,
    purge   => true,
  }

  exec { 'eclipse download':
    command => "curl -qLo eclipse.tar.gz '${dl_url}'",
    cwd     => $tmp,
    unless  => "test -f /var/db/.puppet_compressed_app_installed_${pkg}",
    require => File[$tmp],
    timeout => 1200,
    notify  => Exec['eclipse repack'],
  }

  exec { 'eclipse repack':
    command     => "tar xzf eclipse.tar.gz && mv eclipse ${pkg}.app && tar czf ${pkg}.tar.gz ${pkg}.app",
    cwd         => $tmp,
    refreshonly => true,
    require     => File[$tmp],
    creates     => "${tmp}/${pkg}.tar.gz",
    notify      => Package['eclipse'],
  }

  package { 'eclipse':
    ensure   => installed,
    name     => $pkg,
    source   => "file://${tmp}/${pkg}.tar.gz",
    alias    => 'eclipse',
    provider => compressed_app,
    require  => File[$tmp],
  }

  file { $app:
    ensure  => link,
    target  => "/Applications/${pkg}.app/Eclipse.app",
    require => Package[$pkg],
    notify  => Exec['eclipse cleanup'],
  }

  exec { 'eclipse cleanup':
    command     => "rm -rf ${tmp}",
    cwd         => '/',
    refreshonly => true,
    require     => File[$app],
  }

}
