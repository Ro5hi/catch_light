class PhotosController < ApplicationController

    
  get '/photos' do
    if logged_in?
      redirect to '/recent'
    end 
  end 

  get '/photos/new' do 
    if logged_in?
      erb :upload
    else 
      redirect to '/index'
    end 
  end 

  post '/photos' do 
    if logged_in? 
      redirect to '/recent'
        if @photos.save
          redirect to "/recent/#{photo.id}"
        else 
          redirect to '/recent'
      end
    else
      redirect to '/login'
    end
  end

  get '/photos/:id' do 
        if logged_in?
            @photos = Photos.find_by_id(paramas[:id])
            erb :'photos/show_photo'
        else
            redirect to '/recent'
        end
    end

    get '/photos/:id/edit' do 
            if logged_in?
                @photos = Photos.find_by_id(params[:id])
            if @photos && @photos.user == current_user 
                erb :'photos/edit_photo'
            else 
                redirect to '/recent'
            end 
        else 
            redirect to '/index'
        end
    end

    patch '/photos/:id' do 
        if logged_in?
            if params[:content] == ""
                redirect to "/recent/#{params[:id]}/edit"
            else
                @photos = Photos.find_by_id(params[:id])
                if @photos && @photos.user == current_user
                    if @photos.update(content: params[:content])
                        redirect to "/recent/#{@photos.id}"
                    else
                        redirect to "/recent/#{@photo.id}/edit"
                    end
                else
                    redirect to '/recent'
                end
            end
        else
            redirect to '/index'
        end
    end

    delete '/photos/:id/delete' do 
        if logged_in?
            @photos = Photos.find_by_id(params[:id])
            if @photos && @photos.user == current_user 
                @photos.delete
            end
                    redirect to '/recent'
            else
                redirect to '/login'
            end
        end
    end 