require "test_helper"

class TicketStatusLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_status_log = ticket_status_logs(:one)
  end

  test "should get index" do
    get ticket_status_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_status_log_url
    assert_response :success
  end

  test "should create ticket_status_log" do
    assert_difference("TicketStatusLog.count") do
      post ticket_status_logs_url, params: { ticket_status_log: { new_status_id: @ticket_status_log.new_status_id, observation: @ticket_status_log.observation, previous_status_id: @ticket_status_log.previous_status_id, ticket_id: @ticket_status_log.ticket_id, user_id: @ticket_status_log.user_id } }
    end

    assert_redirected_to ticket_status_log_url(TicketStatusLog.last)
  end

  test "should show ticket_status_log" do
    get ticket_status_log_url(@ticket_status_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_status_log_url(@ticket_status_log)
    assert_response :success
  end

  test "should update ticket_status_log" do
    patch ticket_status_log_url(@ticket_status_log), params: { ticket_status_log: { new_status_id: @ticket_status_log.new_status_id, observation: @ticket_status_log.observation, previous_status_id: @ticket_status_log.previous_status_id, ticket_id: @ticket_status_log.ticket_id, user_id: @ticket_status_log.user_id } }
    assert_redirected_to ticket_status_log_url(@ticket_status_log)
  end

  test "should destroy ticket_status_log" do
    assert_difference("TicketStatusLog.count", -1) do
      delete ticket_status_log_url(@ticket_status_log)
    end

    assert_redirected_to ticket_status_logs_url
  end
end
