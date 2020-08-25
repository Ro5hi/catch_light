class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "QpNLmgTz"
  end

  get '/' do
    erb :home
  end

  get '/oop' do 
    erb :'/users/oop'
  end 

  get '/invalid' do 
    erb :'users/invalid'
  end 

  get '/restricted' do 
    erb :'users/restricted'
  end 
  
  helpers do
  
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def protected!
      if !logged_in?
      redirect to '/invalid'
      end 
    end
    
    def owned(photos)
      binding.pry
      user = User.find_by(params[:user_id])
      photos.user == user 
    end 

    def error 
      redirect to '/oop'
    end 

  end 
  
end