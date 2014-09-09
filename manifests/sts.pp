# install Spring Tool Suite
class eclipse::sts(
  $ensure   = present,
  $version  = '3.6.1.201408250818-RELEASE-e44',
  $repo     = join([
                'http://dist.springsource.com/release/TOOLS/update/e4.4',
                'http://update.atlassian.com/atlassian-eclipse-plugin/rest/e3.7',
                'http://download.eclipse.org/tools/orbit/downloads/drops/I20140701152614/repository',
              ], ',')
) {

  include eclipse

  eclipse::feature{ 'org.springsource.sts.package':
    ensure  => $ensure,
    version => $version,
    repo    => $repo,
  }

}
