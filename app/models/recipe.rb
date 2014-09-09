class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :quantities
  has_many :comments
  has_many :cookbook_entries
  has_many :cookbooks, through: :cookbook_entries

  has_and_belongs_to_many :categories, autosave: true, inverse_of: :categoryies
  
  validates :name, presence: true
  validates :instructions, presence: true
  
  accepts_nested_attributes_for :quantities, :categories, allow_destroy: true
end