class ActivityPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  validates :repetitions, numericality: { greater_than: 0 }
  validates :date, presence: true
  
  validate :date, :activity_plan_may_not_be_in_past
      
  def activity_plan_may_not_be_in_past
    errors.add(:date, 'Cannot plan activities in the past.') unless self.date >= Date.today
  end
end
