class SportType < ApplicationRecord
  has_many :sport_combinations, dependent: :destroy
  has_many :places, through: :sport_combinations
  validates :name, presence: true
end
