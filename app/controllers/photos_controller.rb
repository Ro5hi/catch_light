class PhotosController < ApplicationController
    
  get '/photos' do
    if logged_in?
      erb :recent 
    end 
  end 

  get '/photos/new' do 
    if logged_in?
      erb :'recent/new'
    end 
  end 

  post '/photos' do 
      
  end 


  get '/photos/:id' do 
      @photo = Photo.find(params[:id])
      erb :'user/profile'
  end 

  get '/photos/:id/edit' do 
      @photo = Photo.find(params[:id])
      erb :profile
  end 
  
  delete '/photos/:id/delete' do 
      if logged_in?
          @photos = Photos.find_by_id(params[:id])
          if @photos && @photos.user == current_user 
          @photos.delete
              redirect to '/profile'
          else
              redirect to '/recent'
          end
      end
  end 