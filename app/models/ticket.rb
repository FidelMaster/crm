class Ticket < ApplicationRecord
  belongs_to :team
  belongs_to :status, class_name: 'TicketStatus'
  belongs_to :created_by, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :location
  belongs_to :service_type
  belongs_to :location_group
end
