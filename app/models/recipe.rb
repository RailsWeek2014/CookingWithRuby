class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :quantities
  
  validates :name, presence: true
  validates :instructions, presence: true
end
