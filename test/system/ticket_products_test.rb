require "application_system_test_case"

class TicketProductsTest < ApplicationSystemTestCase
  setup do
    @ticket_product = ticket_products(:one)
  end

  test "visiting the index" do
    visit ticket_products_url
    assert_selector "h1", text: "Ticket products"
  end

  test "should create ticket product" do
    visit ticket_products_url
    click_on "New ticket product"

    fill_in "Observation", with: @ticket_product.observation
    fill_in "Product", with: @ticket_product.product_id
    fill_in "Quantity", with: @ticket_product.quantity
    fill_in "Ticket", with: @ticket_product.ticket_id
    click_on "Create Ticket product"

    assert_text "Ticket product was successfully created"
    click_on "Back"
  end

  test "should update Ticket product" do
    visit ticket_product_url(@ticket_product)
    click_on "Edit this ticket product", match: :first

    fill_in "Observation", with: @ticket_product.observation
    fill_in "Product", with: @ticket_product.product_id
    fill_in "Quantity", with: @ticket_product.quantity
    fill_in "Ticket", with: @ticket_product.ticket_id
    click_on "Update Ticket product"

    assert_text "Ticket product was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket product" do
    visit ticket_product_url(@ticket_product)
    accept_confirm { click_on "Destroy this ticket product", match: :first }

    assert_text "Ticket product was successfully destroyed"
  end
end
