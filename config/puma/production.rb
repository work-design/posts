dir = ENV['PWD']

plugin :tmp_restart

port 3002
workers 2
threads 2, 32
environment 'production'
directory dir
daemonize true
prune_bundler true
#early_hints true

bind "unix://#{File.expand_path('tmp/sockets/puma.sock', dir)}"
pidfile "#{File.expand_path('tmp/pids/puma.pid', dir)}"
state_path "#{File.expand_path('tmp/sockets/puma.state', dir)}"
activate_control_app "unix://#{File.expand_path('tmp/sockets/pumactl.sock', dir)}"
stdout_redirect "#{File.expand_path('log/puma.stdout.log', dir)}",
                "#{File.expand_path('log/puma.stdout.log', dir)}",
                true

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

on_restart do
  puts "\n-----> On restart"
  puts "env: #{@options[:environment]}"
  puts "pidfile: #{@options[:pidfile]}"
  puts "binds: #{@options[:binds]}"
  puts "control_url: #{@options[:control_url]}"
end
