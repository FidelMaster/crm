class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.string :type_ticket
      t.string :contact_name
      t.string :contact_phone
      t.datetime :scheduled_date
      t.datetime :arrived_date
      t.datetime :start_service_date
      t.datetime :end_service_date
      t.float :total_hour_service
      t.text :technical_observation
      t.decimal :longitude_arrived
      t.decimal :latitude_arrived
      t.decimal :longitude_end_work
      t.decimal :latitude_end_work
      t.decimal :cost
      t.references :team, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: { to_table: :ticket_statuses }
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :assigned_to, null: false, foreign_key: { to_table: :users }
      t.references :location, null: false, foreign_key: true
      t.references :service_type, null: false, foreign_key: true
      t.references :location_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
