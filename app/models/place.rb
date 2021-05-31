class Place < ApplicationRecord
  belongs_to :user
  has_many :visits
  has_many :likes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sport_combinations
  has_many :sport_types, through: :sport_combinations
end