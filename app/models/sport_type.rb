class SportType < ApplicationRecord
  SPORT_TYPES = %w(Basketball Football Volleyball Ping-Pong Skiing Hiking Climbing Kayaking Spikeball SUP Handball Skate-boarding Skating Surfing)
  has_many :sport_combinations
  has_many :places, through: :sport_combinations
  validates :name, presence: true
end
