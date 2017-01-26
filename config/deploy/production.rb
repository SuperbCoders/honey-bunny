# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.


role :app, %w{deploy@89.223.29.241}
role :web, %w{deploy@89.223.29.241}
role :db,  %w{deploy@89.223.29.241}

set :branch, 'master'
set :deploy_to, '/var/www/myhoneybunny.ru'
