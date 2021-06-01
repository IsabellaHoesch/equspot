class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_place, only: [ :show, :edit, :update ]

  def index
    @places = policy_scope(Place)
    # search bar - by sport
    @dropdown = SportType.all
    if params[:query].present? && params[:sport].present?
      sql_query = "places.name ILIKE :query AND sport_types.name ILIKE :sport"
      @places = Place.joins(:sport_combination).where(sql_query, query: "%#{params[:query]}%", sport: "%#{params[:sport]}%")
    
    elsif params[:sport].present? && !params[:sport].blank?
     # sql_query = "sport_types.name ILIKE :sport"
     # @places = Place.joins(:sport_combination).where(sql_query, query: "%#{params[:query]}%", sport: "%#{params[:sport]}%") # , sport: "%#{params[:sport]}%"
      # @places = Place.where(
      #   "JOIN sport_combinations ON places.id = sport_combinations.place_id
      #    JOIN sport_types ON sport_type.id = sport_combinations.sport_type_id
      #    WHERE sport_types.name = :sport", sport: "#{params[:sport]}")


     @places = Place.joins(:sport_types ).where('name = :sport', sport: "#{params[:sport]}")
    # @places = Place.joins(:sport_combinations).left_joins(:ratings).where(ratings: { id: nil  })


    elsif params[:query].present?
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
