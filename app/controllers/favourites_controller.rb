class FavouritesController < ApplicationController
  def index
    # @place = Place.find(params[:place_id])
    @favourites = policy_scope(Favourite)
  end

  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @favourite = Favourite.new
    @favourite.user = @user
    @favourite.place = @place
    authorize @favourite
    if @favourite.save
      redirect_to places_path, notice: "Added to the fav."
    else
      render "places/show"
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    authorize @favourite
    redirect_to favourites_path
  end

  private

  def restaurant_params
    params.require(:favourite).permit(:place_id)
  end
end
