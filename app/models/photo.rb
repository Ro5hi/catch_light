require_relative 'photo_uploader'

class Photo < ActiveRecord::Base

    belongs_to :user
    mount_uploader :file, PhotoUploader
    
end 