class Identity < ActiveRecord::Base
  belongs_to :user
  
  validates :provider, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  validates :secret, presence: true
end
