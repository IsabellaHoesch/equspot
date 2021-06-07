class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :place_id, uniqueness: { scope: :user_id, message: "This place is already in your favourite list!" }
end
