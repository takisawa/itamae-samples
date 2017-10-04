# frozen_string_literal: true

group 'deploy' do
  action :create
end

user 'deploy' do
  action :create
  gid 'deploy'
  create_home true
end

remote_file '/etc/sudoers.d/deploy' do
  owner 'root'
  group 'root'
  mode '0400'
end
