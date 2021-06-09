class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @places = policy_scope(Place)

    @markers = Place.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "places/info_window", locals: { place: place }),
        image_url: helpers.asset_url("#{place.sport_types.first.name}.png")
      }
    end
    @top_places = Place.where.not(visits_count: nil).order("visits_count desc").limit(10)
  end

  def dashboard
    @places = Place.all
    @user = current_user
    # @sporttypes = SportType.all
    @visit_this_month = @user.visits.where("created_at > ?", 4.weeks.ago).count 
    @visit_past_month = @user.visits.where('created_at BETWEEN ? AND ?', 8.weeks.ago, 4.weeks.ago).count 
    @percentage_change_month = (@visit_past_month.fdiv(@visit_this_month) / @visit_past_month * 100).to_f.nan? ? 0 : (@visit_past_month.fdiv(@visit_this_month) / @visit_past_month * 100).round(0)
    @motivational_msg = @percentage_change_month.positive? ? "Great job!" : "#{@user.first_name}, you´re slacking! Get going!"
  end

  def about
  end

  def contact
  end

  def profile
    @user = current_user
  end
end
