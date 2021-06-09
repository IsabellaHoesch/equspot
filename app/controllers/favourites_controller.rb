class FavouritesController < ApplicationController
  def index
    # @place = Place.find(params[:place_id])
    @favourites = current_user.favourites
    @surf = SportType.find_by(name: "Surf")
    @basketball = SportType.find_by(name: "Basketball")
    @calisthenics = SportType.find_by(name: "Calisthenics")
    @ping_pong = SportType.find_by(name: "Ping-Pong")
  end

  def show
    @surf = SportType.find_by(name: "Surf")
    @basketball = SportType.find_by(name: "Basketball")
    @calisthenics = SportType.find_by(name: "Calisthenics")
    @ping_pong = SportType.find_by(name: "Ping-Pong")
  end


  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @favourite = Favourite.new
    @favourite.user = @user
    @favourite.place = @place
    authorize @favourite
    if @favourite.save
      redirect_to place_path(@place), notice: "Added to favourites."
    else
      # render "places/show"
      redirect_to place_path(@place), notice: "Already on the list."
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    authorize @favourite
    @favourite.destroy
    redirect_to favourites_path, notice: "Succesfully removed."
  end

  private

  def favourite_params
    params.require(:favourite).permit(:place_id)
  end
end
