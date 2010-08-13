require 'spec_helper'

describe Restis::App do

	def app
		Restis::App
	end

	it "should respond to /" do
		get '/'
		last_response.should be_ok
	end
end
