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
  
  # post '/login' do
  #   if user = User.create(email: params[:email], password: params[:password])
  #     session[:user_id] = user.id 
  #     erb :'users/hello'
  #   else
  #       redirect to 'users/home'
  #   end 
  # end

  post '/signup' do
    if params[params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""]
       erb :'users/home'
    else
        user = User.create(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        redirect to 'users/hello'
    end 
  end

  patch '/users/:id' do 
    @current_user = User.find_by(id: params[:id])
    if @current_user && @current_user.update(email: params[:email], password: params[:password])
      @current_user.update(params)
      redirect to 'users/editprofile'
    end 
  end 

  get '/editprofile' do
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    erb :'users/editprofile' 
  end 
  
  get '/users/hello' do
    erb :'users/hello'
  end 

  get '/upload' do
    erb :'photos/upload' 
  end 

  get '/login' do
    if logged_in?
      erb :'users/home'
    else 
      redirect '/users/hello/#{@user.id}'
    end 	    
  end 

  get '/users/home' do
    erb :'users/home'
  end 

  # get '/users/goodbye' do 
  #   session.clear
  #   erb :'users/goodbye' 
  # end 

  get '/logout' do 
    session.clear 
    erb :'users/goodbye'
  end 
  
end