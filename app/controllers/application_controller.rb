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
  
  post '/signup' do
    if params[params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""]
       erb :'users/home'
    else
        user = User.create(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        redirect to 'photos/recent'
    end 
  end 

  get '/editprofile' do
    #protected!
    erb :'users/editprofile' 
  end 

  get '/community' do
    
    erb :community
  end 
  binding.pry

  get '/recent' do 
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
    @ids = User.find(params[:user_id]) 
    erb :'photos/recent'
  end 

  get '/upload' do
    
    erb :'photos/upload' 
  end 

  get '/login' do
    if logged_in?
      erb :'users/home'
    else 
      redirect 'photos/recent'
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

  get '/logout' do
    session[:user_id] = nil 
  end 

end