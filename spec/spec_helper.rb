require 'init'

Bundler.require :test
require 'sinatra'

require 'rspec'
require 'rack/test'

Rspec.configure do |conf|
  conf.include Rack::Test::Methods
end


set :environment, :test
set :run, false
set :raise_errors, :true
set :logging, false
