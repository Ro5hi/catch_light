ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite3"
)


CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/public"
end


require_all 'app'