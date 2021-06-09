class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :visits, dependent: :destroy
  # places user has created
  has_many :places, dependent: :destroy # place has a dependency on user (foreign_key)
  # places user has visited
  has_many :visited_places, through: :visits, class_name: "Place", source: :place
  has_many :sport_combinations, through: :visited_places
  has_many :sport_types, through: :sport_combinations
  has_many :favourites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :chatroom_visits, dependent: :destroy

end
