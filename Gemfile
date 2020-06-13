# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.1'

gem 'activesupport'
gem 'builder'
gem 'kramdown'
gem 'rack-cache'
gem 'sinatra'
gem 'sinatra-r18n'
gem 'thin'

group :development do
  gem 'byebug'
end

group :development, :test do
  # code style
  gem 'rubocop'
  # testing framework
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', '< 0.18'
end

group :test do
  gem 'rspec_junit_formatter'
end
