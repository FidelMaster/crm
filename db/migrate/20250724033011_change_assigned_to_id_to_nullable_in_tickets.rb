class ChangeAssignedToIdToNullableInTickets < ActiveRecord::Migration[7.1]
  def change
    # Le decimos a la tabla :tickets que la columna :assigned_to_id puede ser nula (true)
    change_column_null :tickets, :assigned_to_id, true
  end
end