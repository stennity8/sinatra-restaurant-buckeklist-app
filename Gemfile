source 'http://rubygems.org'
ruby '2.6.1'

gem 'sinatra'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'pg'
gem 'rake'
gem 'require_all'
gem 'sqlite3', '~> 1.3.6', :group => :development
gem 'thin'
gem 'shotgun', :group => :development
gem 'pry', :group => :development
gem 'bcrypt'
gem 'tux', :group => :development
gem 'sinatra-flash'


group :test do
  gem 'rspec'
  gem 'capybara', '>= 2.7.1'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
