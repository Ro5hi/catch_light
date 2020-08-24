require 'bcrypt'

class User < ActiveRecord::Base

    has_secure_password

    has_many :photos

    attr_accessor :password, :email, :user_id

    validates_presence_of :email, :password_digest, :password 
    validates_uniqueness_of :email
   
end