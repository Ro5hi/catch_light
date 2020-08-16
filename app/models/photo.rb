require_relative 'photo_uploader'

class Photo < ActiveRecord::Base

    attr_accessor :id,  :file
    # validates :url, uniqueness: true, presence: true  
    belongs_to :user
    mount_uploader :file, PhotoUploader
    

end 