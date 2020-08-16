class PhotosController < ApplicationController

    get '/photos' do 
      @photos = Photo.all
      @users = User.all
      erb :'photos/recent'
    end 

    post '/photos' do
        puts "#{params[:file]}"
        photo = Photo.new
      
        photo.url = params[:file][:filename]
        photo.save!
      
        File.open("./public/uploads/#{photo.url}", 'wb') do |f|
        f.write(params[:file][:tempfile].read)
      end
      
      redirect to("/photos/recent")
    
    end

    get '/photos/:id' do 
      photo = Photo.new 
      photo = Photo.find_by(id: params[:id])
      redirect to("/photos")
    end
    
    post '/photos/:id' do 
      @photo = Photo.find_by(params[:user_id])
      @photo.name = params['photo']['name']
      @photo.save 
      redirect to "photos/#{photo.id}"
    end

    get '/photos/delete' do 
      if logged_in?
        @photo = Photo.find_by(params[:user_id])
        if @photo.delete 
          erb :'user/home'
        else 
          redirect to '/photos'
        end 
      end 
    end

    
end