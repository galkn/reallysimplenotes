class Note < ActiveRecord::Base
  attr_accessible :body, :id, :token
  belongs_to :user
  
  paginates_per 1
  validates :body, :presence => true
  
end
