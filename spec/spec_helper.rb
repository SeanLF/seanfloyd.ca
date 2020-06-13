# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'bundler'
Bundler.require(:default, :test)

require File.expand_path('../app.rb', __dir__)

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
