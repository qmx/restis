module Restis
	class App < Sinatra::Base

		QUEUES_KEY = "queues"
		@@redis = Redis.new

		def redis
			@@redis
		end

		get '/' do
			"ok"
		end

		get '/q/?' do
			result = []
			redis.smembers(QUEUES_KEY).each do |queue|
				result << ({queue => redis.llen(queue)})
			end
			{:queues => result}.to_json
		end

		get '/q/:queue' do |queue|
			result = redis.lpop(queue)
		end

		post '/q/:queue' do |queue|
			redis.sadd(QUEUES_KEY, queue)
		end

		put '/q/:queue' do |queue|
			redis.sadd(QUEUES_KEY, queue)
			par = params.dup
			par.delete("queue")
			redis.rpush(queue, par.to_json)
		end
	end
end
