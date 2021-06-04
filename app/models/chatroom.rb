class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :sport_type

  def show
    @chatroom = Chatroom.find(params[:id])
  end
end
