class Category < ActiveRecord::Base
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories
  
  validates_uniqueness_of :name
  validates :name, presence: true
end
