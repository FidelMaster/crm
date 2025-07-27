require "application_system_test_case"

class TicketStatusLogsTest < ApplicationSystemTestCase
  setup do
    @ticket_status_log = ticket_status_logs(:one)
  end

  test "visiting the index" do
    visit ticket_status_logs_url
    assert_selector "h1", text: "Ticket status logs"
  end

  test "should create ticket status log" do
    visit ticket_status_logs_url
    click_on "New ticket status log"

    fill_in "New status", with: @ticket_status_log.new_status_id
    fill_in "Observation", with: @ticket_status_log.observation
    fill_in "Previous status", with: @ticket_status_log.previous_status_id
    fill_in "Ticket", with: @ticket_status_log.ticket_id
    fill_in "User", with: @ticket_status_log.user_id
    click_on "Create Ticket status log"

    assert_text "Ticket status log was successfully created"
    click_on "Back"
  end

  test "should update Ticket status log" do
    visit ticket_status_log_url(@ticket_status_log)
    click_on "Edit this ticket status log", match: :first

    fill_in "New status", with: @ticket_status_log.new_status_id
    fill_in "Observation", with: @ticket_status_log.observation
    fill_in "Previous status", with: @ticket_status_log.previous_status_id
    fill_in "Ticket", with: @ticket_status_log.ticket_id
    fill_in "User", with: @ticket_status_log.user_id
    click_on "Update Ticket status log"

    assert_text "Ticket status log was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket status log" do
    visit ticket_status_log_url(@ticket_status_log)
    accept_confirm { click_on "Destroy this ticket status log", match: :first }

    assert_text "Ticket status log was successfully destroyed"
  end
end
