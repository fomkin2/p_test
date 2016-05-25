user     = 'staging-www'
app_name = 'promo'
host     = '121.41.51.233'
repo_url = 'git@github.com:ielts-assistant/promo.git'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :web, ["#{user}@#{host}"]
role :app, ["#{user}@#{host}"]
role :db,  ["#{user}@#{host}"]

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/unicorn/staging.rb}

set :application, app_name
set :repo_url, repo_url
set :branch, 'develop'
set :deploy_to, '~/' + app_name
set :rails_env, :staging
set :tmp_dir, "/home/#{ user }/tmp"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    # Reload unicorn with capistrano3-unicorn hook
    # needs to be before "on roles()"
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

end
