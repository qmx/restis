require 'init'

Bundler.require :test
require 'sinatra'

require 'spec'
require 'rack/test'

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
end


set :environment, :test
set :run, false
set :raise_errors, :true
set :logging, false
