require 'spec_helper'

describe Restis::App do

	def app
		Restis::App
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
				post '/q/order/'
				last_response.should be_ok
				get '/q'
				last_response.body.should =~ /order/
			end
			it "should get the head of the queue" do
				post '/q/order', :id => 3
				last_response.should be_ok
				get '/q/order'
				last_response.body.should == "{'id': 3}"
			end
		end
	end
end
