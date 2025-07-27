require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "should create ticket" do
    visit tickets_url
    click_on "New ticket"

    fill_in "Arrived date", with: @ticket.arrived_date
    fill_in "Assigned to", with: @ticket.assigned_to_id
    fill_in "Contact name", with: @ticket.contact_name
    fill_in "Contact phone", with: @ticket.contact_phone
    fill_in "Cost", with: @ticket.cost
    fill_in "Created by", with: @ticket.created_by_id
    fill_in "Description", with: @ticket.description
    fill_in "End service date", with: @ticket.end_service_date
    fill_in "Latitude arrived", with: @ticket.latitude_arrived
    fill_in "Latitude end work", with: @ticket.latitude_end_work
    fill_in "Location group", with: @ticket.location_group_id
    fill_in "Location", with: @ticket.location_id
    fill_in "Longitude arrived", with: @ticket.longitude_arrived
    fill_in "Longitude end work", with: @ticket.longitude_end_work
    fill_in "Priority", with: @ticket.priority
    fill_in "Scheduled date", with: @ticket.scheduled_date
    fill_in "Start service date", with: @ticket.start_service_date
    fill_in "Status", with: @ticket.status_id
    fill_in "Team", with: @ticket.team_id
    fill_in "Technical observation", with: @ticket.technical_observation
    fill_in "Title", with: @ticket.title
    fill_in "Total hour service", with: @ticket.total_hour_service
    fill_in "Type service", with: @ticket.type_service_id
    fill_in "Type ticket", with: @ticket.type_ticket
    click_on "Create Ticket"

    assert_text "Ticket was successfully created"
    click_on "Back"
  end

  test "should update Ticket" do
    visit ticket_url(@ticket)
    click_on "Edit this ticket", match: :first

    fill_in "Arrived date", with: @ticket.arrived_date
    fill_in "Assigned to", with: @ticket.assigned_to_id
    fill_in "Contact name", with: @ticket.contact_name
    fill_in "Contact phone", with: @ticket.contact_phone
    fill_in "Cost", with: @ticket.cost
    fill_in "Created by", with: @ticket.created_by_id
    fill_in "Description", with: @ticket.description
    fill_in "End service date", with: @ticket.end_service_date
    fill_in "Latitude arrived", with: @ticket.latitude_arrived
    fill_in "Latitude end work", with: @ticket.latitude_end_work
    fill_in "Location group", with: @ticket.location_group_id
    fill_in "Location", with: @ticket.location_id
    fill_in "Longitude arrived", with: @ticket.longitude_arrived
    fill_in "Longitude end work", with: @ticket.longitude_end_work
    fill_in "Priority", with: @ticket.priority
    fill_in "Scheduled date", with: @ticket.scheduled_date
    fill_in "Start service date", with: @ticket.start_service_date
    fill_in "Status", with: @ticket.status_id
    fill_in "Team", with: @ticket.team_id
    fill_in "Technical observation", with: @ticket.technical_observation
    fill_in "Title", with: @ticket.title
    fill_in "Total hour service", with: @ticket.total_hour_service
    fill_in "Type service", with: @ticket.type_service_id
    fill_in "Type ticket", with: @ticket.type_ticket
    click_on "Update Ticket"

    assert_text "Ticket was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket" do
    visit ticket_url(@ticket)
    accept_confirm { click_on "Destroy this ticket", match: :first }

    assert_text "Ticket was successfully destroyed"
  end
end
