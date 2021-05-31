class SportType < ApplicationRecord
  has_many :sport_combinations
  has_many :places, through: :sport_combinations
end
