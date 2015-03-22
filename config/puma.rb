workers Integer(ENV["WEB_CONCURRENCY"] || 2)
thread_count = Integer(ENV["WEB_THREADS"] || 5)
threads thread_count, thread_count
port ENV['PORT'] || 3000

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
