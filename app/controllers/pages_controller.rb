class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @places = policy_scope(Place)

    @markers = Place.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "places/info_window", locals: { place: place }),
        image_url: helpers.asset_url('basketball.png')
      }
    end
  end

  def dashboard
    @places = Place.all
    @user = current_user
    # @past_visits = @user.visits
  end
end
