class Api::LocationsController < ApplicationController
  def index
    location_group = LocationGroup.find(params[:location_group_id])
    render json: location_group.locations.select(:id, :description)
  end
end