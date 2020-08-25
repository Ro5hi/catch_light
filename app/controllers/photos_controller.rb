class PhotosController < ApplicationController

  get '/photos/recent/:id' do
    @photos = Photo.all
    @user = User.all
    erb :'photos/recent'
  end 

  get '/photo.url/' do 
    redirect to 'photo/show/:id'
  end 

  get '/photo/show/:id' do 
    @photos = Photo.all 
    @user = current_user
    erb :'photos/show'
  end 

  get '/photos' do
    @photos = Photo.all 
    @users = User.all 
    erb :'photos/recent'
  end 

  get '/upload' do
    protected!
    @user = current_user
    erb :'photos/upload' 
  end

  post '/photos' do
    @user = current_user
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
    @photos = Photo.find_by(id: params[:user_id])
    redirect to("/photos")
  end 
  
  post '/photos/:id' do
    @photos = Photo.find_by(id: params[:user_id])
    redirect to("/photos")
  end

  delete '/photos/:id' do 
    protected!
    photos = Photo.find_by(params[:user_id])
    if owned(photos)
       photos.destroy 
       redirect to '/photos'
    else 
      content_protected
    end  
  end 

end