class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :places, dependent: :destroy # place has a dependency on user (foreign_key)
  has_many :likes
  has_many :favourites
  has_many :comments
  has_many :visits
end
