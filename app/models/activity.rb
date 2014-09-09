class Activity < ActiveRecord::Base
  has_many :activity_plans
  
  validates :name, presence: true
  validates :repetitions, numericality: { greater_than: 0 }
end
