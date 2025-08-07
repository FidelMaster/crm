# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  # Primero, asegúrate de que el usuario esté logueado con Devise
  before_action :authenticate_user!
  # Luego, crea un método para verificar si es admin
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if  @user.save
      redirect_to admin_users_path, notice: "Usuario creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # ... (edit, update, destroy) ...

  private

  def authenticate_admin!
    redirect_to root_path, alert: "No tienes permiso para acceder a esta sección." unless current_user.admin?
  end


  def user_params
    # Si la contraseña está en blanco, la filtramos para no intentar actualizarla.
    if params[:user][:password].blank?
      params.require(:user).permit(:name, :email, :role, :name)
    else
      params.require(:user).permit(:name, :email, :role, :name, :password, :password_confirmation)
    end
  end
end