class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :sport_type
  has_many :chatroom_visits, dependent: :destroy

  def show
    @chatroom = Chatroom.find(params[:id])
  end

  def unread_msg(user)
    @latest_visit = chatroom_visits.where(user: user).order(updated_at: :desc).first
    return 0 if @latest_visit.nil?

    return messages.where("created_at > ?",  @latest_visit.updated_at).count
  end
end
