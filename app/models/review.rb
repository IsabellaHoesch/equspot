class Review < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :content, length: { minimum: 5, message: "Comment has to be at least 5 characters" }
end
