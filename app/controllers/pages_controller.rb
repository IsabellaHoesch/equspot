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
    @visit_this_month = @user.visits.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count
    @visit_past_month = @user.visits.where(created_at: Time.zone.now.prev_month(1) .. Time.zone.now.beginning_of_month).count 
    @percentage_change_month = @visit_this_month.zero? || @visit_past_month.zero?  ? 0 : (((@visit_this_month-@visit_past_month).to_f/(@visit_past_month).to_f) * 100).round(0)
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
