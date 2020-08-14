ENV['SINATRA_ENV'] ||= "development"

require './config/environment'


use Rack::MethodOverride
use UsersController
use PhotosController
run ApplicationController 