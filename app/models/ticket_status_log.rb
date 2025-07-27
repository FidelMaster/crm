class TicketStatusLog < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  belongs_to :previous_status, class_name: 'TicketStatus'
  belongs_to :new_status, class_name: 'TicketStatus'
end
