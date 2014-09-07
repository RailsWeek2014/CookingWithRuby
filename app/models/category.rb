class Category < ActiveRecord::Base
  belongs_to :category
  validates_uniqueness_of :name
  validates :name, presence: true
end
