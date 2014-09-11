class Quantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :unit
  belongs_to :ingredient
  
  validates :quantity, presence: true, numericality: { greater_than_or_equal: 0 }
end
