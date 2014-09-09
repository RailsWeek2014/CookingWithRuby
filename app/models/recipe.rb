class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, dependent: :destroy
  has_many :quantities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories
  has_many :cookbook_entries, dependent: :destroy
  
  validates :name, presence: true
  validates :instructions, presence: true
  
  accepts_nested_attributes_for :quantities, :recipe_categories, allow_destroy: true
end
