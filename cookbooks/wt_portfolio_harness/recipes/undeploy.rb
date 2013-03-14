#
# Cookbook Name:: wt_portfolio_harness
# Recipe:: undeploy
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
#

log_dir      = "#{node['wt_common']['log_dir_linux']}/edgeservice"
install_dir  = "#{node['wt_common']['install_dir_linux']}/edgeservice"


runit_service "edgeservice" do
  action :disable
end 

# try to stop the service, but allow a failure without printing the error
service "edgeservice" do
  action [:stop, :disable]
  ignore_failure true
end

directory log_dir do
  recursive true
  action :delete
end

directory install_dir do
  recursive true
  action :delete
end