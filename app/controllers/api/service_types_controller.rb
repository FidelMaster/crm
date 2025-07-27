class Api::ServiceTypesController < ApplicationController
  def index
    team = Team.find(params[:team_id])
    render json: team.service_types.select(:id, :description)
  end
end