class Ingredient < ActiveRecord::Base
  has_many :quantities
  belongs_to :unit
end
