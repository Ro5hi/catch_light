class Photos < ActiveRecord::Base

    has_many :profiles
    has_many :user_photos
    belongs_to :user

end 