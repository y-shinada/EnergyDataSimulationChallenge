set :user, 'y-shinada'
set :rails_env, 'staging'

set :branch, ENV['BRANCH'] || 'master'

set :bundle_flags, '--deployment'
set :bundle_path, shared_path.join('vendor', 'bundle')

set :rbenv_path, '/opt/anyenv/envs/rbenv'
set :rbenv_ruby, '2.5.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_tag, fetch(:application)
set :puma_worker_timeout, 60
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :nginx_flag_options, {
  max_fails: 2,
  fail_timeout: 60,
}
set :nginx_flags, fetch(:nginx_flag_options).to_a.map { |a| a.join('=') }.join(' ')
set :nginx_server_names, [
  "localhost",
  "staging.hello-energy-personal.net",
]
set :nginx_server_name, fetch(:nginx_server_names).join(' ')
set :nginx_socket_flags, fetch(:nginx_flags)
set :nginx_use_ssl, false

server "54.178.170.155", user: fetch(:user), roles: %w{app db web}, ssh_options: {
  port: 22,
  forward_agent: true,
  keys: ['config/certs/hello-energy-pem.pem'],
}
