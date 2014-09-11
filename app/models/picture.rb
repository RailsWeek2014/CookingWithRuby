class Picture < ActiveRecord::Base
  belongs_to :recipe
  
  validates :picture_path, presence: true
end
