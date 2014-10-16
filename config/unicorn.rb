# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/speakeasy"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/speakeasy/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/var/www/speakeasy/log/unicorn.log"
stdout_path "/var/www/speakeasy/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.speakeasy.sock"
listen "/tmp/unicorn.speakeasy.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
