#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

CtfRegistrar::Application.load_tasks

namespace :deploy do
  task :staging => 'assets:precompile' do
    sh "git push heroku master"
  end

  task :prod => 'assets:precompile' do
    sh "git push heroku-prod master"
  end
end
