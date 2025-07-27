class CreateTicketStatusLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_status_logs do |t|
      t.text :observation
      t.references :user, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.references :previous_status, null: false, foreign_key: { to_table: :ticket_statuses }
      t.references :new_status, null: false, foreign_key: { to_table: :ticket_statuses }

      t.timestamps
    end
  end
end
