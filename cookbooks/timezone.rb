# frozen_string_literal: true

execute 'cp -p /etc/localtime{,.orig}' do
  not_if 'test -e /etc/localtime.orig'
end

link '/etc/localtime' do
  to '/usr/share/zoneinfo/Asia/Tokyo'
  force true
end

remote_file '/etc/sysconfig/clock' do
  owner 'root'
  group 'root'
  mode '0644'
end
