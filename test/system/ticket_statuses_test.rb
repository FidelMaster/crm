require "application_system_test_case"

class TicketStatusesTest < ApplicationSystemTestCase
  setup do
    @ticket_status = ticket_statuses(:one)
  end

  test "visiting the index" do
    visit ticket_statuses_url
    assert_selector "h1", text: "Ticket statuses"
  end

  test "should create ticket status" do
    visit ticket_statuses_url
    click_on "New ticket status"

    fill_in "Code", with: @ticket_status.code
    fill_in "Description", with: @ticket_status.description
    click_on "Create Ticket status"

    assert_text "Ticket status was successfully created"
    click_on "Back"
  end

  test "should update Ticket status" do
    visit ticket_status_url(@ticket_status)
    click_on "Edit this ticket status", match: :first

    fill_in "Code", with: @ticket_status.code
    fill_in "Description", with: @ticket_status.description
    click_on "Update Ticket status"

    assert_text "Ticket status was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket status" do
    visit ticket_status_url(@ticket_status)
    accept_confirm { click_on "Destroy this ticket status", match: :first }

    assert_text "Ticket status was successfully destroyed"
  end
end
