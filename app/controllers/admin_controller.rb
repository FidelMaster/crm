class AdminController < ApplicationController
  before_action :authorize_admin!

  def dashboard
    # Lógica para el dashboard
 

  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Acceso denegado." unless current_user.admin?
  end
end