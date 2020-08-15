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
  
  post '/login' do
    if user = User.create(name: params[:name], email: params[:email], password: params[:password])
      session[:user_id] = user.id 
      erb :'users/hello'
    else
        redirect to 'users/home'
    end 
  end

  post '/signup' do
    if params[params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""]
       erb :'users/home'
    else
        user = User.create(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        redirect to 'users/hello'
    end 
  end 

  get '/editprofile' do
    #protected!
    erb :'users/editprofile' 
  end 

  get '/community' do
    
    erb :community
  end 
  
  get '/users/hello' do 
    erb :'users/hello'
  end 

  # # get '/recent' do 
  # get '/photos/recent' do 
  #   @photo = Photo.find(params[:id])
  #   @user = User.find(params[:user_id])
  #   # @ids = User.find(params[:user_id]) 
  #   erb :'photos/recent'
  # end 

  get '/upload' do
    
    erb :'photos/upload' 
  end 

  get '/login' do
    if logged_in?
      erb :'users/hello'
    else 
      redirect '/users/hello/#{@user.id}'
    end 
  end

  # get '/signup' do
  #   if params[:email] == "" || params[:password] == ""
  #     erb :'users/home'
  #   else
  #     user = User.create(email: params[:email], password: params[:password])
  #     puts "Created User: #{user.id}" 
  #     session[:user_id] = user.id
  #     redirect to '/recent'
  #   end
  # end

  get '/users/home' do
    redirect 'users/home'
  end 

  get '/logout' do 
    session.clear 
    redirect 'users/home'
  end 
  
end