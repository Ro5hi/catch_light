class PhotosController < ApplicationController

    get '/photos' do 
      erb :'/login/recent'
    end 
    
    get '/photos/:id' do 
      @photo.id = Photo.find(params[:id])
      erb :'/recent/#{@photo.id}'
    end

    post '/photos' do 
      if logged_in?
        @file = Photo.create!(params[:file])
        @photo = Photo.create!(url:@file)
        current_user.photos << @photo
        redirect '/recent'
      end 
    end

    post '/photos/:id' do 
      @photo = Photo.find(params[:id])
      @photo.save 
      redirect to '/recent/#{@photo.id}'
    end

 
end