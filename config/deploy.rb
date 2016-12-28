# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'godbound'
set :repo_url, 'git@github.com:rickenharp/godbound.git'
set :rbenv_type, :user
set :rbenv_ruby, '2.4.0'
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_jobs, 4

set :ssh_options, {
  forward_agent: true,
}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/www/godbound.geekwire.net'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'store', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  %w[start stop].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_godbound #{command}"
      end
    end
  end

  desc 'Manage Unicorn'
  task :restart do
    on roles(:app), in: :sequence, wait: 1 do
      invoke "deploy:stop"
      invoke "deploy:start"
    end
  end

  after :publishing, :restart

end
