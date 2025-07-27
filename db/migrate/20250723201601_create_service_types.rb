class CreateServiceTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :service_types do |t|
      t.string :description
      t.boolean :is_active
      t.boolean :is_billable
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
