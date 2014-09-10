class Activity < ActiveRecord::Base
  has_many :activity_plans
  
  validates :name, presence: true
  validates :kj, numericality: { greater_than: 0 }
    
  validates :name, uniqueness: true
end
