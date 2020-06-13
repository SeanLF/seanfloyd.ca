# frozen_string_literal: true

require './app'
require 'rack/cache'

use Rack::Cache,
    metastore: 'file:/var/cache/rack/meta',
    entitystore: 'file:/var/cache/rack/body',
    verbose: true

run App
