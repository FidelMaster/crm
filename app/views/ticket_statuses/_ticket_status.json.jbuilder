json.extract! ticket_status, :id, :code, :description, :created_at, :updated_at
json.url ticket_status_url(ticket_status, format: :json)
