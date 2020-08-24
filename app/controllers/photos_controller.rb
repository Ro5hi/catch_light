class PhotosController < ApplicationController

    get '/photos' do
      protected!
      @photos = Photo.all
      @user = User.all
      @current_user = User.find_by(id: params[:user_id])
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
      @current_user = User.find_by(id: params[:user_id])

      photo.url = params[:file][:filename]
      photo.save!
        
      File.open("./public/uploads/#{photo.url}", 'wb') do |f|
      f.write(params[:file][:tempfile].read)
      end
      redirect to("/photos")
    end    

    get '/photos/:id' do 
      photo = Photo.new 
      photo = Photo.find_by(id: params[:user_id])
      redirect to("/photos")
    end

    get '/photos/delete' do 
      @photo = Photo.find_by(params[:user_id])
      if @current_user = User.find_by(id: params[:user_id])
         @photo.delete 
         erb :'/photos/delete' 
      else 
        redirect to '/users/oop'
      end
    end

    patch '/photos/:id/delete' do
      @photos = Photo.find_by(params[:user_id])
      @current_user = User.find_by(id: params[:user_id])
      @current_user && @current_user.update(@photos)
      @current_user.update(@photos)
    end 

    post '/photos/:id/delete' do
      @current_user = User.find_by(id: params[:user_id])
      @photo = Photo.find_by(params[:user_id])
      @photo.destroy
      redirect to '/photos'
    end 

 
end