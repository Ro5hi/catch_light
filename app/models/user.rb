class User < ActiveRecord::Base

  has_secure_password
  
  has_many :photos

  validates :username, uniqueness: {case_sensitive: false}, presence: true
  validates :email, uniqueness: {case_sensitive: false}, presence: true
  validates :password , presence: true

end