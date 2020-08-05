class PhotosController < ApplicationController

    
  get '/photos' do
    if logged_in?
      @photos = Photos.all
      erb :photos
    else 
      redirect to '/login'
    end 
  end 

  get '/photos/new' do 
    if logged_in?
      erb:'photos/upload_photo'
    else 
      redirect to 'login'
    end 
  end 

  post '/photos' do 
    if logged_in? 
      if params[:content] == "" 
        redirect to "/photos/new"
      else
        @photos = current_user.photos.build(content: params[:content])
        if @photos.save
          redirect to "/photos/#{photo.id}"
        else 
          redirect to "/photos/new"
        end
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
            redirect to 'login'
        end
    end

    get '/photos/:id/edit' do 
            if logged_in?
                @photos = Photos.find_by_id(params[:id])
            if @photos && @photos.user == current_user 
                erb :'photos/edit_photo'
            else 
                redirect to '/photos'
            end 
        else 
            redirect to '/login'
        end
    end

    patch '/photos/:id' do 
        if logged_in?
            if params[:content] == ""
                redirect to "/photos/#{params[:id]}/edit"
            else
                @photos = Photos.find_by_id(params[:id])
                if @photos && @photos.user == current_user
                    if @photos.update(content: params[:content])
                        redirect to "/photos/#{@photos.id}"
                    else
                        redirect to "/photos/#{@photo.id}/edit"
                    end
                else
                    redirect to '/photos'
                end
            end
        else
            redirect to '/login'
        end
    end

    delete '/photos/:id/delete' do 
        if logged_in?
            @photos = Photos.find_by_id(params[:id])
            if @photos && @photos.user == current_user 
                @photos.delete
            end
                    redirect to '/photos'
            else
                redirect to '/login'
            end
        end
    end 