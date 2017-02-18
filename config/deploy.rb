# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, "honey-bunny"
set :repo_url, 'git@github.com:honeybunnyru/honey-bunny.git'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml config/oauth.yml config/w1.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
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

  desc 'Seeds default data to database'
  task :seed do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, "exec rake db:seed RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end

  desc 'run some rake tasks with params'
  task :run_rake_task, :param do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, args[:param]
        end
      end
    end
  end
end
after 'deploy:updated', 'deploy:seed'
