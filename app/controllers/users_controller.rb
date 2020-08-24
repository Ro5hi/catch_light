class UsersController < ApplicationController   

    get '/login' do
      if logged_in?
        erb :'users/hello'
      else 
        redirect to '/invalid'
      end 
    end 

    post '/login' do 
       if @user = User.find_by(name: params[:name], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect to '/users/hello'
       else 
        redirect to '/invalid'
      end 
    end

    post '/signup' do
      if params[params[:name] = "" || params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""]
         erb :'users/home'
      else
          @user = User.create(name: params[:name], email: params[:email], password: params[:password])
          session[:user_id] = @user.id.to_s
          redirect to 'users/hello'
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

    get '/editprofile' do
      if authorized?
        erb :'users/editprofile' 
      else
        redirect to '/invalid' 
      end 
    end

    post '/users/:id' do
      protected!
      @current_user = User.find_by(id: params[:id])
      @current_user.update(params)
      redirect to 'users/editprofile' 
    end 

    patch '/users/:id' do
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