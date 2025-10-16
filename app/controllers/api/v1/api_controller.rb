# app/controllers/api/v1/api_controller.rb
class Api::V1::ApiController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    header = request.headers['Authorization']
    token = header&.split(' ')&.last
    decoded = JwtService.decode(token) rescue nil
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { error: 'No autorizado' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
