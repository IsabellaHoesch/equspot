class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index]  

def index
  @places = policy_scope(Place)
end

end
