class Note < ActiveRecord::Base
  attr_accessible :body, :id
  belongs_to :user
  
  paginates_per 2  
  validates :body, :presence => true
  
end
