module Restis
	class App < Sinatra::Base

		@@client = Restis::Client.new

		get '/' do
			"ok"
		end

		put '/q/:queue' do |queue|
			par = params.dup
			par.delete("queue")
			@@client.publish(queue, par.to_json)
			halt 200
		end
	end
end
