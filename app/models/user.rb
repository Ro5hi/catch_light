class User < ActiveRecord::Base

    has_secure_password
    has_many :photo

    validates_presence_of :email, :password_digest
    validates_uniqueness_of :email, presence: {message: "That email is already taken, please use another email."}

end