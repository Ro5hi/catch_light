class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "QpNLmgTz"
  end

  get '/' do
    erb :'users/home'
  end

  get '/oop' do 
    erb :'/users/oop'
  end 
  
  helpers do
  
    def logged_in?
      !!current_user
    end
    
    def current_user
      User.find_by(id: session[:user_id])
    end

    def protected!
      if !logged_in?
      redirect to '/oop'
      end 
    end 

    def authorized?
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end 
  
end