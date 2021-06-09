class Place < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :sport_combinations, dependent: :destroy
  has_many :sport_types, through: :sport_combinations
  has_many_attached :photos
  validates :name, presence: true, uniqueness: true, length: { maximum: 50, message: "no longer than 50 characters." }
  validates :description, presence: true, length: { maximum: 250, message: "no longer than 250 characters." }
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  def average_rating
    ratings = reviews.map { |review| review.rating }
    if ratings.length.zero?
      0
    else
      ratings.sum / ratings.length
    end
  end
end
