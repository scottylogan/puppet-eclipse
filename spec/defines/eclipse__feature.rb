require 'spec_helper'


describe 'eclipse::feature' do

  describe 'when installing the default version' do
    let (:params) {{
      :ensure   => 'present',
      :title    => 'com.salesforce.ide.feature',
      :version  => '31.0.0.201406301722',
      :repo     => 'http://media.developerforce.com/force-ide/eclipse42',
    }}
    it { should contain_exec('eclipse com.salesforce.ide.feature install').with({
      :creates => '/Applications/eclipse-luna-R.app/features/com.salesforce.ide.feature_31.0.0.201406301722',
    })}
  end

  describe 'when removing the default version' do
    let (:params) {{
      :ensure   => 'absent',
      :title    => 'com.salesforce.ide.feature',
      :version  => '31.0.0.201406301722',
      :repo     => 'http://media.developerforce.com/force-ide/eclipse42',
    }}
    it { should contain_exec('eclipse com.salesforce.ide.feature uninstall') }
  end

  describe 'when installing a specific version' do
    let (:params) {{
      :ensure   => 'present',
      :title    => 'com.salesforce.ide.feature',
      :version  => '30.0.0.201401011200',
      :repo     => 'http://media.developerforce.com/force-ide/eclipse42',
    }}

    it { should contain_exec('eclipse com.salesforce.ide.feature install').with({
      :creates => '/Applications/eclipse-luna-R.app/features/com.salesforce.ide.feature_30.0.0.201401011200',
    })}

  end

end