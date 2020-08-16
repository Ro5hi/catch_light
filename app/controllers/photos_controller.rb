class PhotosController < ApplicationController

    get '/photos' do 
      binding.pry
      @photos = Photo.all 
      @users = User.all
      erb :'photos/recent'
    end 

    post '/photos' do
      photo = Photo.new

      @filename = params[:file => :filename]
      file = params[:file => :tempfile]
      
      Photo.file = params[:file] 
      Photo.save!
      
      redirect to("/photos/recent")

    end

    get '/photos/:id' do 
      @photos.id = Photo.find_by(user_id: params[:user_id])
      erb :'photos/recent'
    end

  #   post "photos/recent" do
  #     #Create new Image Model
  #     photo = Photo.new
  #     #Save the data from the request
  #     photo.file    = params[:file] #carrierwave will upload the file automatically
  #     #Save
  #     photo.save!
  #     #Redirect to view
  #     redirect to "photos/recent"
  # end
    
    post '/photos/:id' do 
      @photo = Photo.find_by(params[:user_id])
      @photo.name = params['photo']['name']
      @photo.save 
      redirect to 'photos/#{photo.id}'
    end

    
end