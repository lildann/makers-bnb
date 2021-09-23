# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.3'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-flash'
gem 'sinatra-activerecord'
gem 'rake'
gem 'pg'
gem "bcrypt"

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development, :test do
  gem 'rubocop', '1.20'
end
