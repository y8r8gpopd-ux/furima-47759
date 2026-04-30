lock '3.20.0'

set :application, 'furima-47759'

set :repo_url,  'git@github.com:y8r8gpopd-ux/furima-47759.git'
set :branch, 'main'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads')
set :bundle_path, -> { shared_path.join('bundle') }
set :rbenv_type, :user
set :rbenv_ruby, '3.2.0' 
set :rbenv_path, '$HOME/.rbenv'
set :default_env, {
  PATH: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/my-key-pair.pem'] 

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end