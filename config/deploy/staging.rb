# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{w3dev-hb@ono.rrv.ru:2223}
role :web, %w{w3dev-hb@ono.rrv.ru:2223}
role :db,  %w{w3dev-hb@ono.rrv.ru:2223}

set :branch, 'develop'
set :deploy_to, '/www/dev-hb.onomnenado.ru'

namespace :deploy do
  task :robots do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "echo 'Disallow: /' > public/robots.txt"
      end
    end
  end
end
after 'deploy:updated', 'deploy:robots'
