class PhotosController < ApplicationController

    get '/photos' do 
      @photos = Photo.all
      @users = User.all
      erb :'photos/recent'
    end 

    get '/upload' do
      if logged_in?
      erb :'photos/upload' 
      end 
    end 

    post '/photos' do
      puts "#{params[:file]}"
      photo = Photo.new
      user = User.new 

      photo.url = params[:file][:filename]
      photo.save!
        
      File.open("./public/uploads/#{photo.url}", 'wb') do |f|
      f.write(params[:file][:tempfile].read)
      end
      redirect to("/photos/recent")
    end    

    get '/photos/:id' do 
      photo = Photo.new 
      photo = Photo.find_by(id: params[:user_id])
      redirect to("/photos")
    end

    # post '/photos/:id' do 
    #   @photo = Photo.find_by(params[:user_id])
    #   @photo.name = Photo.find(params[:filename])
    #   @photo.save 
    #   redirect to "photos/#{photo.id}"
    # end

    get '/photos/delete' do 
      if logged_in?
        @photo = Photo.find_by(params[:user_id])
        @photo.delete 
          erb :'/photos/delete'
        else 
          error 
      end 
    end

    post'/photos/:id' do
      if logged_in?
        @photo = Photo.find_by(params[:user_id])
        @photo.destroy
          redirect to '/photos'
      else 
        error  
      end 
    end 

 
end