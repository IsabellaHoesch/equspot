class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_place, only: [ :show, :edit, :update ]

  def index
    @places = policy_scope(Place)

    # search bar - by sport
    @dropdown = SportType.all
    if params[:query].present? && params[:sport][:id].present?
      @places = Place.joins(:sport_combinations).where("places.address ILIKE ? AND sport_combinations.sport_type_id = ?", "%#{params[:query]}%", params[:sport][:id].to_i)
    elsif params[:sport].present? && !params[:sport][:id].blank?
      sql_query = "sport_types.id = :sport"
      @places = Place.joins(:sport_types).where(sql_query, sport: params[:sport][:id].to_i)
    elsif params[:query].present? && params[:sport][:id].blank?
      sql_query = "address ILIKE :query"
      @places = Place.where(sql_query, query: "%#{params[:query]}%")
    else
      @places = Place.all
    end
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url("#{place.sport_types.first.name}.png")
      }
    end
  end

  def show
    set_place
    @visits_count = @place.visits.where("created_at > ?", 180.minutes.ago).count
    if @visits_count.zero?
      @busyness = "No one is currently here."
    elsif @visits_count == 1
      @busyness = "1 person is here."
    else
      @busyness = "#{@visits_count} people are here."
    end
    @reviews = @place.reviews
    @ratings = @reviews.map { |review| review.rating }
    if @ratings.length.zero?
      @average_rating = 0
    else
      @average_rating = @ratings.sum / @ratings.length
    end
    authorize @place
    @markers = [{
        lat: @place.latitude,
        lng: @place.longitude,
        info_window: render_to_string(partial: "address_window", locals: { place: @place }),
        image_url: helpers.asset_url("#{@place.sport_types.first.name}.png")
      }]
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

  def destroy
    set_place
    authorize @place
    @place.destroy
    redirect_to profile_path, notice: "Spot successfully removed."
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address, :description, photos: [], sport_type_ids: [])
  end
end
