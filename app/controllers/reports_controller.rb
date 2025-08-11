class ReportsController < ApplicationController
  def index
    # Ejemplo para el gráfico de Tickets por Estado
    @tickets_by_status = Ticket.joins(:status).group('ticket_statuses.description').count

    # Ejemplo para el gráfico de Tendencia de Creación
    @tickets_trend = Ticket.group_by_day(:created_at).count
  end
end
