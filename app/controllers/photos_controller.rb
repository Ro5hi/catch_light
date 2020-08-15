class PhotosController < ApplicationController

    get '/photos' do 
      @photos = Photos.all 
      @users = User.all 
      erb :'photos/recent'
    end 

    post '/photos' do
        @filename = params[:file => :filename]
        file = params[:file => :tempfile]
        @photo= Photo.create!(url:@filename)
        current_user.photos << @photo

        File.open("./public/#{@photo.url}") do |file|
          file.write(file.read)
        end
        
        redirect to "/photos/#{@photo.id}"
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