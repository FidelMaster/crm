class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.text :description
      t.integer :stock
      t.boolean :is_active

      t.timestamps
    end
  end
end
