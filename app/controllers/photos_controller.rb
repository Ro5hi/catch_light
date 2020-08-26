class PhotosController < ApplicationController

  get '/photos/recent/:id' do
    @photos = Photo.all
    @user = User.all
    erb :'photos/recent'
  end 
  
  get '/user/profile' do
    @photos = Photo.where(user_id: current_user.id)
    erb :'photos/recent'
  end

  get '/photos/show/:id' do
    @current_user = current_user
    @photo = Photo.find(params[:id])
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
    photo = current_user.photos.build

    photo.title = params[:title]
    photo.url = params[:file][:filename]
    photo.save!
    
    File.open("./public/uploads/#{photo.url}", 'wb') do |f|
    f.write(params[:file][:tempfile].read)

    redirect to ("/photos/show/#{photo.id}")
    end
    redirect to("/photos/recent/#{photo.id}")
  end   

  get '/photos/:id' do  
    @photos = Photo.find_by(id: params[:user_id])
    redirect to("/photos")
  end 
  
  post '/photos/:id' do
    protected!
    @photo = Photo.find_by(id: params[:id])
    if @photo.user_id == current_user.id  
       @photo.title = params[:title]
       @photo.save!
       redirect to("/photos/show/#{@photo.id}")
    else 
       content_protected
    end 
  end

  delete '/photos/:id' do 
    protected!
    if photos = Photo.find_by(id: params[:id])
       photos.destroy 
       redirect to '/photos'
    else 
      content_protected
    end  
  end 

end