class PhotosController < ApplicationController

  def current_user
    User.find(session[:user_id])
  end

  def photos  
    @photo = Photo.find_by(id: params[:id])
  end 

  get '/photos/recent/:id' do
    @photos = Photo.all
    @user = User.all
    erb :'photos/recent'
  end 

  get '/photos' do
    @photos = Photo.all 
    @users = User.all 
    erb :'photos/recent'
  end 

  get '/upload' do
    protected!
    erb :'photos/upload' 
  end  

  post '/photos' do
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

  post '/photos/:id' do
    @current_user = User.find_by(id: params[:id]) 
    @photo = Photo.find_by(id: params[:id])
    redirect to("/photos")
  end

  post '/photos/:id/delete' do 
    protected!
    @photos = Photo.all  
    @photos = Photo.find_by(id: params[:id])
    @photos.destroy
    redirect to '/photos'
  end 


end