json.extract! ticket_comment, :id, :description, :ticket_id, :user_id, :created_at, :updated_at
json.url ticket_comment_url(ticket_comment, format: :json)
