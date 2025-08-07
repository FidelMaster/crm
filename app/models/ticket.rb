class Ticket < ApplicationRecord
  belongs_to :team
  belongs_to :status, class_name: 'TicketStatus'
  belongs_to :created_by, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :location
  belongs_to :service_type
  belongs_to :location_group

  has_many :ticket_comments
  has_many :ticket_products
  has_many :ticket_status_logs

  enum billing_status: {
    pending_approval: 0, # Pendiente de Aprobación
    payment_pending: 1,  # Pendiente de Pago
    paid: 2,             # Pagado
    rejected: 3          # Rechazado
  }
end
