class Identity < ActiveRecord::Base
  belongs_to :user
  
  validates :provider, presence: true
  validates :uid, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :token, presence: true
  validates :secret, presence: true
end
