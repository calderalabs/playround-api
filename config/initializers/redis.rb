Redis::Settings.configure do |config|
  config.connection = Redis.new(:host => "localhost", :port => 6379)
end

Redis::Settings.root_namespace = "settings"