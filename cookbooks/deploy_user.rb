# frozen_string_literal: true

group 'deploy' do
  action :create
end

user 'deploy' do
  action :create
  gid 'deploy'
  create_home true
end
