require_relative 'photo_uploader'

class Photo < ActiveRecord::Base

    attr_accessor :id, :file
    belongs_to :user
    mount_uploader :file, PhotoUploader

end 