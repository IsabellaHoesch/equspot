class CommentsController < ApplicationController
  def new
    @user = current_user
    @place = Place.find(params[:place_id])
    # @comment.place = @place
    # @comment.user = @user
    @comment = Comment.new
    authorize @comment
  end

  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.place = @place
    authorize @comment
    if @comment.save
      redirect_to place_path(@comment), notice: "Added a comment."
    else
      render "places/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :place_id)
  end
end
