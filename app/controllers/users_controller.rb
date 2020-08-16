class UsersController < ApplicationController

    helpers do
  
      def logged_in?
        !!current_user
      end
      
      def current_user
        puts session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
  
      def protected!
        return if authorized?
        halt 401, "Invalid, Please try again."
      end
  
      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
      end
    end
    
    patch 'users/editprofile' do 
      @user = User.find_by(id: params[:id])
      if @user && @user.update(email: params[:email], password: params[:password])
        @user.update(params)
        redirect to '/editprofile'
      else 
        redirect to 'photos/recent'
      end 
    end 
    
    post '/login' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to 'users/hello'
      else
        puts "Invalid email/password."
      end
    end 

    delete '/users/:id' do
      if logged_in?
        @user = User.find_by(id: params[:id])
        if @user.delete 
          erb :'users/home'
        else 
          redirect to 'users/hello'
        end 
      end 
    end 
  end