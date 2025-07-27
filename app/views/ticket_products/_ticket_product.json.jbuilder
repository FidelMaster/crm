json.extract! ticket_product, :id, :quantity, :observation, :ticket_id, :product_id, :created_at, :updated_at
json.url ticket_product_url(ticket_product, format: :json)
