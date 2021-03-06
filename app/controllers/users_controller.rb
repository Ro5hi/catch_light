class UsersController < ApplicationController   

    post '/signup' do
      if params[params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""]
         invalid_user
      else
          user = User.create(name: params[:name], email: params[:email], password: params[:password])
          session[:user_id] = user.id
          user.save 
          redirect to 'users/hello'
      end 
    end 

    post '/login' do
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect to 'users/hello'
      else
        invalid_user
      end 	    
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

    get '/edit/account' do
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      erb :'users/edit' 
    end

    post '/users/:id' do
      protected!
      @current_user = User.find_by(id: params[:id])
      @current_user.update(params)
      redirect to '/edit/account' 
    end 

    patch '/users/:id' do
      protected!
      @current_user = User.find_by(id: params[:id])
      @current_user && @current_user.update(email: params[:email], password: params[:password])
      @current_user.update(params)
      redirect to '/edit/account' 
    end 

    get '/logout' do
      session.clear 
      erb :'users/goodbye'
    end 
    
  end