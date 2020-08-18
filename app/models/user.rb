class User < ActiveRecord::Base

    has_secure_password
    has_many :photo

    validates_presence_of :email, :password_digest
    validates_uniqueness_of :email

    def email_uniqueness 
        self.errors.add(:'users/home', "Sorry that email is taken.") if User.where(self.email).exists?
    end
    
end