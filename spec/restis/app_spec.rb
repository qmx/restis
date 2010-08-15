require 'spec_helper'

describe Restis::App do

	def app
		Restis::App
	end

	before(:suite) do
		redis = Redis.new
		redis.keys.each do |key|
			redis.del key
		end
	end
	it "should respond to /" do
		get '/'
		last_response.should be_ok
	end

	context "when working" do
		context "on /q namespace" do
			it "should list all queues on get" do
				get '/q'
				last_response.should be_successful
			end
			it "should create a new queue on post" do
				post '/q/order'
				get '/q'
				last_response.body.should =~ /order/
			end
			it "should get the head of the queue" do
				put '/q/order', {'id' => '3'}
				get '/q/order'
				last_response.body.should == "{\"id\":\"3\"}"
			end
		end
	end
end
