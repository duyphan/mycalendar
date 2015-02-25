# config valid only for current version of Capistrano
lock '3.3.5'

require "rvm/capistrano"

set :application, 'mycalendar'
set :repo_url, 'git@github.com:duyphan/mycalendar.git'
# set :rbenv_ruby, '2.1.2'

set :rvm_ruby_string, :local 
set :rvm_autolibs_flag, "read-only"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
# before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset

namespace :deploy do

	desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, "service mycalendar restart"  ## -> line you should add
    end
  end

  task :setup do
    on roles(:app), in: :sequence, wait: 5 do
      execute "rvm:install_rvm"
      execute "rvm:install_ruby"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
