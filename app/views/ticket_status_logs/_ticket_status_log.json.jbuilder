json.extract! ticket_status_log, :id, :observation, :user_id, :ticket_id, :previous_status_id, :new_status_id, :created_at, :updated_at
json.url ticket_status_log_url(ticket_status_log, format: :json)
