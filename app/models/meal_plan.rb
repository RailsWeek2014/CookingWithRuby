class MealPlan < ActiveRecord::Base
  
  validates :date, presence: true
  validates :daytime, presence: true
  
  validates :user_id, presence: true
  validates :recipe_id, presence: true
  
  belongs_to :user
  belongs_to :recipe
end
