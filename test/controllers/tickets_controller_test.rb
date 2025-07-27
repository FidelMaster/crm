require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    assert_difference("Ticket.count") do
      post tickets_url, params: { ticket: { arrived_date: @ticket.arrived_date, assigned_to_id: @ticket.assigned_to_id, contact_name: @ticket.contact_name, contact_phone: @ticket.contact_phone, cost: @ticket.cost, created_by_id: @ticket.created_by_id, description: @ticket.description, end_service_date: @ticket.end_service_date, latitude_arrived: @ticket.latitude_arrived, latitude_end_work: @ticket.latitude_end_work, location_group_id: @ticket.location_group_id, location_id: @ticket.location_id, longitude_arrived: @ticket.longitude_arrived, longitude_end_work: @ticket.longitude_end_work, priority: @ticket.priority, scheduled_date: @ticket.scheduled_date, start_service_date: @ticket.start_service_date, status_id: @ticket.status_id, team_id: @ticket.team_id, technical_observation: @ticket.technical_observation, title: @ticket.title, total_hour_service: @ticket.total_hour_service, type_service_id: @ticket.type_service_id, type_ticket: @ticket.type_ticket } }
    end

    assert_redirected_to ticket_url(Ticket.last)
  end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { arrived_date: @ticket.arrived_date, assigned_to_id: @ticket.assigned_to_id, contact_name: @ticket.contact_name, contact_phone: @ticket.contact_phone, cost: @ticket.cost, created_by_id: @ticket.created_by_id, description: @ticket.description, end_service_date: @ticket.end_service_date, latitude_arrived: @ticket.latitude_arrived, latitude_end_work: @ticket.latitude_end_work, location_group_id: @ticket.location_group_id, location_id: @ticket.location_id, longitude_arrived: @ticket.longitude_arrived, longitude_end_work: @ticket.longitude_end_work, priority: @ticket.priority, scheduled_date: @ticket.scheduled_date, start_service_date: @ticket.start_service_date, status_id: @ticket.status_id, team_id: @ticket.team_id, technical_observation: @ticket.technical_observation, title: @ticket.title, total_hour_service: @ticket.total_hour_service, type_service_id: @ticket.type_service_id, type_ticket: @ticket.type_ticket } }
    assert_redirected_to ticket_url(@ticket)
  end

  test "should destroy ticket" do
    assert_difference("Ticket.count", -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to tickets_url
  end
end
