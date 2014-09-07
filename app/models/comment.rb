class Comment < ActiveRecord::Base
  has_many :answers, class_name: "Comment", foreign_key: "answer_to_id"
  belongs_to :answer_to, class_name: "Comment"
  
  belongs_to :recipe
  belongs_to :user
    
  
end
