# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

server '89.223.29.241', user: 'deploy', roles: %w{app db web}

role :app, %w{deploy@89.223.29.241}
role :web, %w{deploy@89.223.29.241}
role :db,  %w{deploy@89.223.29.241}

set :branch, 'master'
set :deploy_to, '/home/deploy/honney-bunny'

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: 'deploy',
}

set :rails_env, :production
set :conditionally_migrate, true
