class ChangeCoordinatesPrecisionInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :latitude_arrived, :decimal, precision: 10, scale: 6
    change_column :tickets, :longitude_arrived, :decimal, precision: 10, scale: 6
    change_column :tickets, :latitude_end_work, :decimal, precision: 10, scale: 6
    change_column :tickets, :longitude_end_work, :decimal, precision: 10, scale: 6
  end
end
