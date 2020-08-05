class Photos < ActiveRecord::Base

    has_many :profiles
    has_many :user_photos
    has_many :users 

end 