require_relative 'photo_uploader'

class Photo < ActiveRecord::Base

    attr_accessor :id,  :file
    belongs_to :user
    mount_uploader :file, PhotoUploader

    def destroy
        @photo = Photo.find(params[:id])
        if current_user == @photo.user
           @photo.destroy
           redirect to("/photos")
        else 
           redirect to("/oop")
        end 
    end
    

end 