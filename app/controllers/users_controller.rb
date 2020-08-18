class UsersController < ApplicationController

    get '/users/:id' do 
      erb :'users/hello' 
    end 

    get '/login' do
      if logged_in?
        erb :'users/home'
      else 
        redirect '/users/hello/#{@user.id}'
      end 	    
    end 

    get '/users/hello' do
      erb :'users/hello'
    end 

    get '/editprofile' do
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      erb :'users/editprofile' 
    end
    
    get '/users/home/:id' do
      erb :'users/home'
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

    patch '/users/:id' do
      @current_user = User.find_by(id: params[:id])
        if @current_user && @current_user.update(email: params[:email], password: params[:password])
          @current_user.update(params)
          redirect to 'users/editprofile'
        else 
          redirect to 'users/hello'
        end 
    end 

    get '/logout' do 
      session.clear 
      erb :'users/goodbye'
    end 

    # delete '/users/:id/' do
    #   if logged_in?
    #     @user = User.find_by(id: params[:id])
    #     if @user.delete 
    #       erb :'users/home'
    #     else 
    #       redirect to 'users/hello'
    #     end 
    #   end 
    # end

  end