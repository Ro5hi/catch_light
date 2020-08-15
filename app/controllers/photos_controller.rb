class PhotosController < ApplicationController

    get '/photos/:id' do 
      @photos.id = Photo.find_by(user_id: params[:user_id])
      erb :'photos/recent'
    end

    post '/photos' do
        @file = Photo.create!(params[:file])
        @photo = Photo.create!(url:@file)
        redirect 'photos/show'
    end
    
    post '/photos/:id' do 
      @photo = Photo.find_by(params[:user_id])
      @photo.save 
      redirect to 'photos/recent'
    end
end