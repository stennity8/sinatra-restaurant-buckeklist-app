ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Clear db to start fresh while testing
task :remigrate do
  Rake::Task["db:rollback"].execute
  Rake::Task["db:rollback"].execute
  Rake::Task["db:rollback"].execute
  Rake::Task["db:migrate"].execute 
  Rake::Task["db:seed"].execute
end