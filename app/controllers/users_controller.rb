class UsersController < ApplicationController

   
    
    get '/login' do
      if logged_in?
        erb :'users/home'
      else 
        redirect '/users/hello'
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

    post '/login' do 
      @user = User.find_by(name: params[:name], email: params[:email], password: params[:password])
      if @user
        session[:user_id] = @user.id
        redirect '/users/hello'
      end
      redirect '/'
    end
    
    get '/users/hello' do
      if logged_in?
        erb :'users/hello'
      end 
    end

    get '/users/:id' do 
      protected!
      erb :'users/hello' 
    end 

    get '/users/home/:id' do
      protected!
      erb :'users/home'
    end   

    get '/editprofile' do
      protected!
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      erb :'users/editprofile' 
    end

    post '/users/:id' do
      protected!
      @current_user = User.find_by(id: params[:id])
      @current_user.update(params)
      redirect to 'users/editprofile' 
    end 

    patch '/users/:id' do
      protected!
      @current_user = User.find_by(id: params[:id])
      @current_user && @current_user.update(email: params[:email], password: params[:password])
      @current_user.update(params)
      redirect to 'users/editprofile' 
    end 

    get '/logout' do
      session.clear 
      erb :'users/goodbye'
    end 
    
  end