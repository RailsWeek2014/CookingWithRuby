class Cookbook < ActiveRecord::Base
  belongs_to :user
  has_many :cookbook_entries, dependent: :destroy

  validates :name, presence: true
end
