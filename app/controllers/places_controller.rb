class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_place, only: [ :show, :edit, :update ]

  def index
    @places = policy_scope(Place)
    # search bar - by sport
    @dropdown = SportType.all
    if params[:query].present? && params[:sport][:id].present?
      @places = Place.joins(:sport_combinations).where("places.name ILIKE ? AND sport_combinations.sport_type_id = ?", "%#{params[:query]}%", params[:sport][:id].to_i)
    elsif params[:sport].present? && !params[:sport][:id].blank?
      sql_query = "sport_types.id = :sport"
      @places = Place.joins(:sport_types).where(sql_query, sport: params[:sport][:id].to_i)
    elsif params[:query].present? && params[:sport][:id].blank?
      sql_query = "name ILIKE :query"
      @places = Place.where(sql_query, query: "%#{params[:query]}%")
    else
      @places = Place.all
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
