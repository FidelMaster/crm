class CreateLocationGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :location_groups do |t|
      t.string :description

      t.timestamps
    end
  end
end
