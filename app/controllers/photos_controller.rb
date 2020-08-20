class PhotosController < ApplicationController

    get '/photos' do
      protected!
      @photos = Photo.all
      @users = User.all
      erb :'photos/recent'
    end 

    get '/upload' do
      protected!
      erb :'photos/upload' 
    end 

    post '/photos' do
      protected!
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

    get '/photos/delete' do 
      protected!
      @photo = Photo.find_by(params[:user_id])
      @photo.delete 
      erb :'/photos/delete'
    end 

    post'/photos/:id' do
      protected!
      @photo = Photo.find_by(params[:user_id])
      @photo.destroy
      redirect to '/photos'
    end 

 
end