$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV["RACK_ENV"] = "test"

require 'sinatra/protection'
