class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home]

  def home
    # --- Define un alcance base para los tickets según el rol del usuario ---
    if current_user && current_user.admin?
      ticket_scope = Ticket.all
    else
      # Si no es admin, solo muestra los tickets creados por el usuario actual
      ticket_scope = Ticket.where(created_by: current_user)
    end

    # --- KPIs Principales (calculados sobre el alcance definido) ---
    @total_tickets = ticket_scope.count
    @open_tickets_count = ticket_scope.joins(:status).where(ticket_statuses: { code: 'open' }).count
    @pending_payment_count = ticket_scope.where(billing_status: :payment_pending).count
    @total_revenue = ticket_scope.where(billing_status: :paid).sum(:cost)

    # --- Actividad Reciente (calculada sobre el alcance definido) ---
    @recent_tickets = ticket_scope.order(updated_at: :desc).limit(5)
    @recent_comments = TicketComment.where(ticket: ticket_scope).includes(:user, :ticket).order(created_at: :desc).limit(5)
  end
end
