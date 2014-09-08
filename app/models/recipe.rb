class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :quantities
  has_many :comments
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  
  validates :name, presence: true
  validates :instructions, presence: true
  
  accepts_nested_attributes_for :quantities, :recipe_categories, allow_destroy: true
end
