# frozen_string_literal: true

node.validate! do
  {
    rbenv: {
      versions: array_of(string),
      global: string
    }
  }
end

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

node.rbenv.versions.each do |version|
  execute "install ruby #{version}" do
    command "source /home/deploy/.bash_profile_rbenv; rbenv install #{version}"
    not_if "source /home/deploy/.bash_profile_rbenv; rbenv versions | grep #{version}"
    user 'deploy'
  end
end
