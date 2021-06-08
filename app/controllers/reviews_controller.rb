class ReviewsController < ApplicationController
  def new
    @place = Place.find(params[:place_id])
    # @review.place = @place
    # @review.user = @user
    @review = Review.new
    authorize @review
  end

  def create
    @user = current_user
    @place = Place.find(params[:place_id])
    @review = Review.new(review_params)
    @review.user = @user
    @review.place = @place
    @review.rating = 0 if params[:review][:rating].empty?
    authorize @review
    if @review.save
      redirect_to place_path(@place), notice: "Review added."
    else
      render "places/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to place_path(@review.place), notice: "Review deleted."
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
