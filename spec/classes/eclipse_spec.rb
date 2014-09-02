require 'spec_helper'


describe 'eclipse' do

  describe 'when not specifying a version' do
    it { should contain_package('Eclipse-luna-R').with({
      :ensure   => 'installed',
      :provider => 'compressed_app'
    })}
    it { should contain_package('Eclipse-luna-R').with_source('http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/luna/R/eclipse-standard-luna-R-macosx-cocoa-x86_64.tar.gz')}
  end

  describe 'when specifying a specific version' do
    let (:params) {{:version => 'kepler', :release => 'SR2'}}

    it { should contain_package('Eclipse-kepler-SR2')}
    it { should contain_package('Eclipse-kepler-SR2').with_source('http://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/kepler/SR2/eclipse-standard-kepler-SR2-macosx-cocoa-x86_64.tar.gz')}
  end

end