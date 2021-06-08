class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
   # @messages = Message.where
    @message = Message.new()
    ChatroomVisit.create(user: current_user, chatroom: @chatroom)
    authorize @chatroom
  end 

end
