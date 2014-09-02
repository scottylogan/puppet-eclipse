require 'spec_helper'


describe 'eclipse' do

  describe 'when not specifying a version' do
    it { should contain_file('eclipse tarball').with({
      :ensure => 'file',
      :path   => "/opt/boxen/eclipse/eclipse-luna-R.tar.gz",
      :source => 'http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/luna/R/eclipse-standard-luna-R-macosx-cocoa-x86_64.tar.gz',
    })}

    it { should contain_file('/Applications/Eclipse.app').with({
      :ensure => 'link',
      :target => "/opt/boxen/eclipse/eclipse-luna-R/Eclipse.app",
    })}
  end

  describe 'when specifying a specific version' do
    let (:params) {{:version => 'kepler', :release => 'SR2'}}

    it { should contain_file('eclipse tarball').with({
      :ensure => 'file',
      :path   => "/opt/boxen/eclipse/eclipse-kepler-SR2.tar.gz",
      :source => 'http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/kepler/SR2/eclipse-standard-kepler-SR2-macosx-cocoa-x86_64.tar.gz',
    })}

    it { should contain_file('/Applications/Eclipse.app').with({
      :ensure => 'link',
      :target => "/opt/boxen/eclipse/eclipse-kepler-SR2/Eclipse.app",
    })}

  end

end