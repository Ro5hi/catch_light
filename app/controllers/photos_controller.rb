class PhotosController < ApplicationController
  
  get '/photos/recent/:id' do
    @photos = Photo.all
    @user = User.all
    erb :'photos/recent'
  end 

  get '/photos' do
    protected!
    erb :'photos/recent'
  end 

  get '/upload' do
    protected!
    erb :'photos/upload' 
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
    redirect to("/photos/recent/#{photo.id}")
  end   

  get '/photos/:id' do
    protected!
    @current_user = User.find_by(id: params[:id]) 
    @photo = Photo.find_by(id: params[:id])
    redirect to('/photos')
  end

  get '/photos/delete' do
    protected! 
    if @photo = @current_user.photo      
       @photo.delete 
       erb :'/photos/delete' 
    else 
       redirect to '/oop'
    end
  end

  patch '/photos/:id/delete' do
    protected!
    @photos = Photo.find_by(params[:id])
    @current_user = User.find_by(id: params[:user_id])
    @current_user && @current_user.update(@photos)
    @current_user.update(@photos)
  end 

  post '/photos/:id' do 
    if authorized?
      @photo = Photo.find_by(params[:user_id])
      @photo.destroy
      redirect to '/photos/recent'
    else 
      redirect to '/oop'  
    end 
  end 


end