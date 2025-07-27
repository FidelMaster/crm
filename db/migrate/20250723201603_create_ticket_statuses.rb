class CreateTicketStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_statuses do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
