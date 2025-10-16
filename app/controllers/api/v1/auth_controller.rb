# app/controllers/api/v1/auth_controller.rb
class Api::V1::AuthController < Api::V1::ApiController
   # No necesita autenticación
  skip_before_action :authenticate_user!, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    puts user.inspect
    if user&.valid_password?(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: {
        token: token,
        user: {
          id: user.id,
          email: user.email,
          full_name: user.name,
          role: user.role
        }
      }, status: :ok
    else
      render json: { error: 'Credenciales inválidas' }, status: :unauthorized
    end
  end
end
