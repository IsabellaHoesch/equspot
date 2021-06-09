class ApplicationController < ActionController::Base
  before_action :authenticate_user! 
  before_action :update_chatroom_visit!
  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def update_chatroom_visit!
    if current_user && request.referer && request.referer.match?(/.*\/chatrooms\/\d+/)
     chatroom_id =  request.referer.match(/.*\/chatrooms\/(\d+)/)[1]
     if chatroom_id.present?
      chatroom = Chatroom.find_by(id: chatroom_id)
      ChatroomVisit.create(chatroom: chatroom, user: current_user) if chatroom.present?
     end 
    end
  end

end


