class CreateTicketComments < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_comments do |t|
      t.text :description
      t.references :ticket, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
