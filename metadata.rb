name             'sudo_rules'
maintainer       'Linux-Help.org'
maintainer_email 'erenfro@linux-help.org'
license          'GNU Lesser General Public License v3'
description      'Configures sudo rules from data bags using the sudo cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.5'
issues_url       'https://github.com/linux-help/sudo_rules/issues'
source_url       'https://github.com/linux-help/sudo_rules'

%w(redhat centos fedora ubuntu debian freebsd mac_os_x).each do |os|
      supports os
end

depends 'sudo', '>= 2.7.1'

