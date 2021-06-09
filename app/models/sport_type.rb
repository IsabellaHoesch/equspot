class SportType < ApplicationRecord
  has_many :sport_combinations, dependent: :destroy
  has_many :places, through: :sport_combinations
  has_one :chatroom, dependent: :destroy
  has_one_attached :photo
  validates :name, presence: true

  def icon_name
    case name
    when "Basketball"
      "fas fa-basketball-ball fa-2x"
    when "Ping-Pong"
      "fas fa-table-tennis fa-2x"
    when "Surf"
      "fas fa-snowboarding fa-2x"
    when "Calisthenics"
      "fas fa-dumbbell fa-2x"
    else
      "fas fa-basketball-ball fa-2x"
    end
  end
end
