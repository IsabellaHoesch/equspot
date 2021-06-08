class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
   # @messages = Message.where
    @message = Message.new()
    authorize @chatroom
  end 

end
