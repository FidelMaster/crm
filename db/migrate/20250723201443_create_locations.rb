class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :description
      t.references :location_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
