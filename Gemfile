# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.0"

gem "activesupport"
gem "builder"
gem "kramdown"
gem "rack-cache"
gem "sinatra"
gem "sinatra-r18n", "~> 4"
gem "thin"

group :development do
  gem "byebug"
end

group :development, :test do
  # code style
  gem "rubocop"
  gem "rubocop-shopify"
  # testing framework
  gem "rack-test"
  gem "rspec"
  gem "simplecov"
  gem "byebug"
end

group :test do
  gem "rspec_junit_formatter"
end
