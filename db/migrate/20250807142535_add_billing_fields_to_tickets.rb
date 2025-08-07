class AddBillingFieldsToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :billable, :boolean 
    add_column :tickets, :billing_status, :integer 
    add_column :tickets, :invoice_details, :text 
    add_column :tickets, :invoice_contact_name, :text
    add_column :tickets, :invoice_contact_ruc, :text 
    add_column :tickets, :invoice_generate_date, :datetime 
    add_column :tickets, :invoice_payment_date, :datetime 
  end
end
