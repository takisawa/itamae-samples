# frozen_string_literal: true

package 'git'
package 'gcc'
package 'libyaml-devel'
package 'readline-devel'
package 'openssl-devel'
package 'zlib-devel'

git '/home/deploy/.rbenv' do
  repository 'https://github.com/rbenv/rbenv.git'
  user 'deploy'
end

directory '/home/deploy/.rbenv/plugins' do
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

git '/home/deploy/.rbenv/plugins/ruby-build' do
  repository 'https://github.com/sstephenson/ruby-build.git'
  user 'deploy'
end

remote_file '/home/deploy/.bash_profile_rbenv' do
  owner 'deploy'
  group 'deploy'
  mode '0644'
end

execute 'install ruby 2.4.2' do
  command 'source /home/deploy/.bash_profile_rbenv; rbenv install 2.4.2'
  not_if 'source /home/deploy/.bash_profile_rbenv; rbenv versions | grep 2.4.2'
  user 'deploy'
end
