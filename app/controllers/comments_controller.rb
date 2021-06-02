class CommentsController < ApplicationController
  def new
    @user = current_user
    @place = Place.find(params[:place_id])
    # @comment.place = @place
    # @comment.user = @user
    @comment = Comment.new
  end

  def create

  end
end
