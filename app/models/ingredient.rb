class Ingredient < ActiveRecord::Base
  has_many :quantities
  belongs_to :unit

  has_many :recipes, through: :quantities 
  
  validates :name, presence: true
  validates :kj, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :carbohydrate, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :protein, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :fat, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :roughage, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :default_quantity, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :unit_id, presence: true

end
