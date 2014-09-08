class Cookbook < ActiveRecord::Base
  belongs_to :user
  has_many :cookbook_entries
  has_many :recipes, through: :cookbook_entries

end
