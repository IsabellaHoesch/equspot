class Review < ApplicationRecord
  belongs_to :place, :user
  validates :content, presence: true, length: { minimum: 10, message: "Description has to be at least 10 characters" }
end
