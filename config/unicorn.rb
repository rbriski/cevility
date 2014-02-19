worker_processes 3
timeout 30
preload_app true


before_fork do |server, worker|
  # Disconnect all database connection from Sequel
  DB.disconnect
  sleep 1
end

after_fork do |server, worker|
  # Do nothing here and DB will connect automatically
end