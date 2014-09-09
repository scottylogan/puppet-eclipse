# simplify creating eclipse feature classes
define eclipse::feature (
  $ensure   = present,
  $version  = undef,
  $repo     = undef,
) {

  require eclipse

  if $version == undef {
    fail('version cannot be undefined')
  }

  if $ensure == 'present' {
    if $repo == undef {
      fail('repo cannot be undefined')
    }

    $repos  = join([$repo,$eclipse::repo], ',')
    $fpath  = "${eclipse::features}/${title}_${version}"

    exec { "eclipse ${title} install":
      command => "${eclipse::p2} -repository ${repos} -installIU ${title}.feature.group/${version}",
      creates => $fpath,
      require => [
        Package[$eclipse::pkg],
        File[$eclipse::app],
      ],
    }
  } else {
    exec { "eclipse ${title} uninstall":
      command => "${eclipse::p2} -uninstallIU ${title}/${version}",
      onlyif  => "test -d ${fpath}",
      require => [
        Package[$eclipse::pkg],
        File[$eclipse::app],
      ],
    }
  }

}