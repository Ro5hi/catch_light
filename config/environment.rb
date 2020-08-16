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
  config.root = File.dirname(__FILE__) + "/public/img/uploads"
end


Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].each {|f| require f}

require_all 'app'