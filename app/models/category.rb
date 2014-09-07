class Category < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates_uniqueness_of :name
  validates :name, presence: true
end
