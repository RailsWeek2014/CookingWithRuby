class Unit < ActiveRecord::Base
  has_many :quantities
  has_many :ingredients, foreign_key: "default_unit_id"
end
