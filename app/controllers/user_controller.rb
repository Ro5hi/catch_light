class User < ApplicationController
    
    get '/' do
        erb :index
    end

    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    get '/createacct' do
      if !logged_in? 
        erb :index
      else
        redirect to '/recent'
      end
    end  
  
    post '/createacct' do 
      session[:user_id] = 0
      if !User.all.find_by('username' => params[:username])
        user = User.create(params)
      else 
        return erb :index 
      end 
        session[:user_id] = @user.id 
        redirect to '/recent'
    end 
  
    get '/login' do
      if !logged_in?
        erb:'users/login'
      else 
        redirect to '/recent'
      end
    end 
  
    get 'logout' do 
      session.clear
      redirect to '/index'
    end 
  
    post '/login' do 
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to '/recent'
      else 
        redirect to '/index'
      end 
    end
  end 