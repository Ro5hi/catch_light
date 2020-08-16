class PhotosController < ApplicationController

    get '/photos' do 
      @photos = Photo.all 
      @users = User.all
      erb :'photos/recent'
    end 

    post '/photos' do
        puts "#{params[:file]}"
        photo = Photo.new
      
        photo.file = params[:file][:filename]
      

        photo.save!
      
        File.open("./public/uploads/#{params[:file][:filename]}", 'wb') do |f|
        f.write(params[:file][:tempfile].read)
      end
      
      redirect to("/photos")
    
    end

    get '/photos/:id' do 
      # puts "yeet #{params[:id]}"
      @photo = Photo.find_by(id: params[:id])
      erb :'photos/show'
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
      redirect to "photos/#{photo.id}"
    end

    
end