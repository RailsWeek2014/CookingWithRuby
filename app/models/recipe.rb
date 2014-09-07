class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :quantities
  has_many :comments
  
  validates :name, presence: true
  validates :instructions, presence: true
  
  accepts_nested_attributes_for :quantities, allow_destroy: true
end
