require "test_helper"

class TeamMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_membership = team_memberships(:one)
  end

  test "should get index" do
    get team_memberships_url
    assert_response :success
  end

  test "should get new" do
    get new_team_membership_url
    assert_response :success
  end

  test "should create team_membership" do
    assert_difference("TeamMembership.count") do
      post team_memberships_url, params: { team_membership: { team_id: @team_membership.team_id, user_id: @team_membership.user_id } }
    end

    assert_redirected_to team_membership_url(TeamMembership.last)
  end

  test "should show team_membership" do
    get team_membership_url(@team_membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_membership_url(@team_membership)
    assert_response :success
  end

  test "should update team_membership" do
    patch team_membership_url(@team_membership), params: { team_membership: { team_id: @team_membership.team_id, user_id: @team_membership.user_id } }
    assert_redirected_to team_membership_url(@team_membership)
  end

  test "should destroy team_membership" do
    assert_difference("TeamMembership.count", -1) do
      delete team_membership_url(@team_membership)
    end

    assert_redirected_to team_memberships_url
  end
end
