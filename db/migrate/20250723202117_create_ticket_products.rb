class CreateTicketProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_products do |t|
      t.integer :quantity
      t.text :observation
      t.references :ticket, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
