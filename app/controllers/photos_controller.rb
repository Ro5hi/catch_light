class PhotosController < ApplicationController

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
    @photo = Photo.find_by(id: params[:id])
    redirect to("/photos")
  end

  post '/photos/:id' do 
    protected!
    session[:user_id] = @user 
    photo = Photo.find_by(id: params[:id])
    photo.destroy
    redirect to '/photos' 
  end 

end