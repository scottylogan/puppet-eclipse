require 'spec_helper'


describe 'eclipse' do

  describe 'when not specifying a version' do
    it { should contain_package('eclipse').with({
      :ensure => 'installed',
      :name   => 'eclipse-luna-R',
      :source => 'file:///tmp/eclipse/eclipse-luna-R.tar.gz',
    })}

    it { should contain_file('/Applications/Eclipse.app').with({
      :ensure => 'link',
      :target => '/Applications/eclipse-luna-R.app/Eclipse.app',
    })}
  end

  describe 'when specifying a specific version' do
    let (:params) {{:version => 'kepler', :release => 'SR2'}}

    it { should contain_package('eclipse').with({
      :ensure => 'installed',
      :name   => 'eclipse-kepler-SR2',
      :source => 'file:///tmp/eclipse/eclipse-kepler-SR2.tar.gz',
    })}

    it { should contain_file('/Applications/Eclipse.app').with({
      :ensure => 'link',
      :target => '/Applications/eclipse-kepler-SR2.app/Eclipse.app',
    })}

  end

end