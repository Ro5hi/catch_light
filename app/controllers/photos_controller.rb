class PhotosController < ApplicationController
  
  get '/photos/' do
    protected!
    @photos = Photo.all
    @user = User.all
    erb :'photos/recent'
  end 

  get '/upload' do
    protected!
    erb :'photos/upload' 
  end 

  get '/recent' do 
    protected!
    erb :'photos/recent'
  end 

  post '/photos' do
    protected!
    @current_user = User.find_by(id: params[:user_id])
    puts "#{params[:file]}"
    photo = Photo.new

    photo.url = params[:file][:filename]
    photo.save!
      
    File.open("./public/uploads/#{photo.url}", 'wb') do |f|
    f.write(params[:file][:tempfile].read)
    end
    redirect to("/photos/#{photo.id}")
  end   

  post '/photos/:id' do 
    @photos = Photo.all 
    @photo = Photo.find(params[:id])
    @photo.save
    redirect to "/photos/#{@photo.id}"
  end 

  get '/photos/:id' do
    @photos = Photo.all
    @photo = Photo.find_by(params[:id])
    @user = User.find_by(params[:id])
    erb :"photos/show"
  end

  get '/photos/delete' do 
    @photo = Photo.find_by(params[:user_id])
    if @current_user = User.find_by(id: params[:user_id])
       @photo.delete 
       erb :'/photos/delete' 
    else 
      redirect to '/oop'
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