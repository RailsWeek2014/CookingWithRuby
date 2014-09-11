class MealPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  
  has_many :quantities, through: :recipe
  
  validates :date, presence: true
  validates :daytime, presence: true
  
  validates :user_id, presence: true #, numericality: { greater_than_or_equal: 0 }
  validates :recipe_id, presence: true #, numericality: { greater_than_or_equal: 0 }
  
  validates :daytime, inclusion: { in: %w(breakfast lunch dinner) }
  validates :date, uniqueness: { scope: [:daytime, :user_id] }
  
  validate :date, :meal_plan_may_not_be_in_past
    
  def meal_plan_may_not_be_in_past
    errors.add(:date, 'Cannot plan meals in the past.') unless self.date >= Date.today
  end
  
end
