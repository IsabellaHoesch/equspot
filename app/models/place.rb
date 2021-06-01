class Place < ApplicationRecord
  belongs_to :user
  has_many :visits
  has_many :likes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sport_combinations
  has_many :sport_types, through: :sport_combinations
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, message: "Description has to be at least 10 characters" }
  validates :adress, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
