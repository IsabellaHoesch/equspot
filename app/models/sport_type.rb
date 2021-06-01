class SportType < ApplicationRecord
  SPORT_TYPES = %w(Basketball Football Volleyball Ping-Pong Climbing Spikeball Street-Workout Handball Skating Surfing)
  has_many :sport_combinations
  has_many :places, through: :sport_combinations
  validates :name, presence: true
end
