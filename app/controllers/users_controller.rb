class UsersController < ApplicationController

    # post '/signup' do 
    #   if params[params[:email] == "" || params[:password] == "" || params[:confirm_password] == ""
    #      erb :'index/signup'
    #     else
    #       user = User.create(email: params[:email], password: params[:password])
    #       session[:user_id] = user.id
    #       redirect to '/recent'
    #       elsif params[:password] == params[:confirm_password]
    #           erb :index
    #       end 
    #     end 
    #   end 
    # end 
    

    post '/login' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "#{user.email}/recent"
      else
        halt 401 if user.nil?
        session[:user] = user
        200
      end 
    end 

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
      halt 401, "Not authorized."
    end 

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
      end
    end

end