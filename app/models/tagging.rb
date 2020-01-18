class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :question
  
  validates :tag_id, uniqueness: { scope: :question_id}
end
