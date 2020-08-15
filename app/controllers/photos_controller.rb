class PhotosController < ApplicationController
  
    get '/recent' do 
      erb :'photos/recent'
    end 
    binding.pry  
    get '/photos/:id' do 
      @photo.id = Photo.find_by(params[:id])
      erb :'photos/recent/#{@photo.id}'
    end

    post '/photos' do 
      if logged_in?
        @file = Photo.create!(params[:file])
        @photo = Photo.create!(url:@file)
        current_user.photos << @photo
        redirect 'photos/recent'
      end 
    end

    post '/photos/:id' do 
      @photo = Photo.find_by(params[:id])
      @photo.save 
      redirect to 'photos/recent/#{@photo.id}'
    end

 
end