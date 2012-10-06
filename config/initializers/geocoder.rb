Geocoder.configure do |config|
  config.lookup = :mapquest
  config.api_key = ENV['MAPQUEST_API_KEY']
  config.units = :km
end