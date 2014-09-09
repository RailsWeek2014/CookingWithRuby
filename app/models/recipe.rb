class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, dependent: :destroy
  has_many :quantities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cookbook_entries, dependent: :destroy
  has_many :cookbooks, through: :cookbook_entries

  has_and_belongs_to_many :categories, autosave: true
  
  validates :name, presence: true
  validates :instructions, presence: true
  
  accepts_nested_attributes_for :quantities, :categories, allow_destroy: true
end
