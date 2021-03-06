class Recipe < ActiveRecord::Base
  fuzzily_searchable :name, :instructions
  
  
  belongs_to :user
  
  has_many :pictures, dependent: :destroy
  has_many :quantities, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cookbooks, through: :cookbook_entries
  has_many :cookbook_entries, dependent: :destroy

  has_many :ingredients, through: :quantities 
  
  has_and_belongs_to_many :categories, autosave: true
  
  validates :name, presence: true
  validates :instructions, presence: true
  validates :number_of_portions, presence: true, numericality: { greater_than: 0 }
  validates :food_value, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :range, inclusion: {in: ['public', 'registrated', 'private']}
  
  accepts_nested_attributes_for :quantities, :categories, allow_destroy: true
  
  #aus zeitmangel noch nicht komplett
  #umrechnen in gleiche einheiten fehlt noch
  def foodvalue
    quantities = self.quantities
    foodvalue = 0
    
    quantities.each { |quantity|
      ingredient = quantity.ingredient
      foodvalue += quantity.quantity * (ingredient.kj / ingredient.default_quantity)
    }
    self.food_value = foodvalue / self.number_of_portions
  end
  
  def average_rating
    unless self.ratings.count == 0
      rating = self.ratings.sum(:rating) / self.ratings.count
    else
      rating = 0
    end
  end
end
