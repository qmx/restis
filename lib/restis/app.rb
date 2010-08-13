module Restis

	class App < Sinatra::Base

		QUEUES_KEY = "queues"

		def redis
			Redis.new
		end

		get '/' do
			"ok"
		end

		get '/q/?' do
			result = redis.smembers(QUEUES_KEY)
		end

		get '/q/:queue' do |queue|
			r = redis
			r.blpop(queue, 100)
		end

		post '/q/:queue/?' do |queue|
			r = redis
			r.sadd(QUEUES_KEY, queue)
			r.rpush(queue, params['splat'].to_s)
		end
	end
end
