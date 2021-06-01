class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_place, only: [ :show, :edit, :update ]

  def index
    @places = policy_scope(Place)

    @markers = Place.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('EquRent.png')
      }
    end
  end

  def show
    authorize @place
  end

  def new
    @place = Place.new
    authorize @place
  end

  def create
    @user = current_user
    @place = Place.new(place_params)
    @place.user = @user
    authorize @place
    if @place.save
      redirect_to places_path, notice: "Spot was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @place
  end

  def update
    authorize @place
    if @place.update(place_params)
      redirect_to place_path(@place)
    else
      render :edit
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address, :description)
  end

end