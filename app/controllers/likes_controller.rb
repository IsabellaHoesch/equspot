class LikesController < ApplicationController

  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @like = Like.new
    @like.user = @user
    @like.place = @place
    authorize @like

    if @like.save
      redirect_to place_path(@place)
    else
      render "places/show"
    end
  end
end
