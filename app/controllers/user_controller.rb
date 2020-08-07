class User < ActiveRecord::Base
    
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
        erb :'users/create_user'
      else
        redirect to '/photos'
      end
    end  
  
    post '/createacct' do 
      session[:user_id] = 0
      if !User.all.find_by('username' => params[:username])
        user = User.create(params)
      else 
        @error = true 
        return erb :createacct 
      end 
        session[:user_id] = @user.id 
        redirect to '/home'
    end 
  
    get '/login' do
      if !logged_in?
        erb:'users/login'
      else 
        redirect to '/photos'
      end
    end 
  
    get 'logout' do 
      session.clear
      redirect to '/login'
    end 
  
    post '/login' do 
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to '/home'
      else 
        redirect to '/createacct'
      end 
    end
  end 