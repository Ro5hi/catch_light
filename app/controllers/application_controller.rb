require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "QpNLmgTz"
  end

  get '/' do
    erb :index
  end

  get '/editprofile' do
    #protected!
    erb :editprofile 
  end 

  get '/community' do
    
    erb :community
  end 
  
  get '/recent' do 
    @photo = Photo.all 
    erb :recent
  end 

  get '/upload' do
    
    erb :'photos/upload' 
  end 

  get '/login' do
    if logged_in?
      puts "#{user.email} Successful"
      erb :'/#login' 
    else 
      redirect '/recent'
    end 
  end

  get '/signup' do
    if params[:email] == "" || params[:password] == ""
      erb :index
    else
      user = User.create(email: params[:email], password: params[:password])
      puts "Created User: #{user.id}" 
      session[:user_id] = user.id
      redirect to '/recent'
    end
  end

  get '/logout' do
    session[:user_id] = nil 
  end 

end 