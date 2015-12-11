require 'resque-scheduler'
require 'resque/scheduler/server'
if ENV["REDISCLOUD_URL"]
  $redis = Resque.redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis = Resque.redis = Redis.new(host: "localhost", port: "6379")
end
