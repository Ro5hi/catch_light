require_relative 'photo_uploader'

class Photo < ActiveRecord::Base

    attr_accessor :photo_id, :photo
    validates :url, uniqueness: true, presence: true  
    belongs_to :user
    mount_uploader :photo, PhotoUploader

end 