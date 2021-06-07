class VisitsController < ApplicationController
  # def index
  #   # @place = Place.find(params[:place_id])
  #   @visits = policy_scope(Visit)
  # end

  # def new
  #   @visit = Visit.new
  #   authorize @visit
  # end

  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @visit = Visit.new
    @visit.user = @user
    @visit.place = @place
    authorize @visit

    if @visit.save
      redirect_to place_path(@place), notice: "You are checked-in."
    else
      render "places/show"
    end
  end
end
