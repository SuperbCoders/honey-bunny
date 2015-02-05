# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{w3myhoneybunny@ono.rrv.ru:2222}
role :web, %w{w3myhoneybunny@ono.rrv.ru:2222}
role :db,  %w{w3myhoneybunny@ono.rrv.ru:2222}

set :branch, 'master'
set :deploy_to, '/www/myhoneybunny.ru'