class TicketStatus < ApplicationRecord
    has_many :tickets
    has_many :ticket_status_log
end
