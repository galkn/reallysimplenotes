class User < ActiveRecord::Base
  attr_accessible :email, :password
  has_many :notes
  
  validates_presence_of :password
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, 
            :presence => true,
            :uniqueness => true,
            :format => { :with => email_regex }
  
end
