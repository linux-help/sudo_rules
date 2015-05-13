name             'sudo_rules'
maintainer       'Linux-Help.org'
maintainer_email 'erenfro@linux-help.org'
license          'All rights reserved'
description      'Configures sudo rules from data bags using the sudo cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'sudo', '>= 2.7.1'

