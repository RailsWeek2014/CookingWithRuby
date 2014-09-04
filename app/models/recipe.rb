class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  
  validates :name, presence: true
  validates :instructions, presence: true
end
