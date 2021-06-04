class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :places, dependent: :destroy # place has a dependency on user (foreign_key)
  has_many :likes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
