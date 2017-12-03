 
require 'digest/md5'
require_relative 'message'

# Defines User class
class User < ActiveRecord::Base
  validates :username, :password, presence: true
  validates :email, format: {
    with: /[a-zA-z0-9]+@[a-zA-z0-9]+.[a-zA-z]+/,
    message: 'Email must be a string'
  }
  has_and_belongs_to_many :teams
  has_many :courts, dependent: :destroy
  
  def password=(new_password)
    self[:password] = Digest::MD5.hexdigest(new_password)
  end
end
