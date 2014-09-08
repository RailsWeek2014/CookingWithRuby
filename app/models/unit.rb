class Unit < ActiveRecord::Base
  has_many :quantities
  has_many :ingredients, foreign_key: "default_unit_id"
  
  has_one :conversion_unit, class_name: "Unit", foreign_key: "conversion_unit_id"
  belongs_to :conversion_unit, class_name: "Unit"
end
