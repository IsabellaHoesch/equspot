class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :content, length: { minimum: 10, message: "Comment has to be at least 10 characters" }
end
