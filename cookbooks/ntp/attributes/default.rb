#
# Cookbook Name:: ntp
# Attributes:: default
#
# Author:: Joshua Timberman (<joshua@opscode.com>)
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# default attributes for all platforms
default['ntp']['servers']   = %w{ 0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org }
default['ntp']['peers'] = Array.new
default['ntp']['restrictions'] = Array.new

default['ntp']['packages'] = %w{ ntp ntpdate }
default['ntp']['service'] = "ntp"
default['ntp']['varlibdir'] = "/var/lib/ntp"
default['ntp']['driftfile'] = "#{node['ntp']['varlibdir']}/ntp.drift"
default['ntp']['conffile'] = "/etc/ntp.conf"
default['ntp']['statsdir'] = "/var/log/ntpstats/"
default['ntp']['conf_owner'] = "root"
default['ntp']['conf_group'] = "root"
default['ntp']['var_owner'] = "ntp"
default['ntp']['var_group'] = "ntp"

# overrides on a platform-by-platform basis
case platform
when "redhat","centos","fedora","scientific","amazon","oracle"
  default['ntp']['service'] = "ntpd"
  default['ntp']['packages'] = %w{ ntp }
  if node['platform_version'].to_i >= 6
    default['ntp']['packages'] = %w{ ntp ntpdate }
  end
when "freebsd"
  default['ntp']['service'] = "ntpd"
  default['ntp']['varlibdir'] = "/var/db"
  default['ntp']['driftfile'] = "#{node['ntp']['varlibdir']}/ntpd.drift"
  default['ntp']['statsdir'] = "#{node['ntp']['varlibdir']}/ntpstats"
  default['ntp']['packages'] = %w{ ntp }
  default['ntp']['conf_group'] = "wheel"
  default['ntp']['var_group'] = "wheel"
when "windows"
  default['ntp']['service'] = "NTP"
  default['ntp']['driftfile'] = "C:\\NTP\\ntp.drift"
  default['ntp']['conffile'] = "C:\\NTP\\etc\\ntp.conf"
  default['ntp']['conf_owner'] = "Administrators"
  default['ntp']['conf_group'] = "Administrators"
  default['ntp']['package_url'] = "http://www.meinberg.de/download/ntp/windows/ntp-4.2.4p8@lennon-o-lpv-win32-setup.exe"
end
