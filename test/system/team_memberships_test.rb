require "application_system_test_case"

class TeamMembershipsTest < ApplicationSystemTestCase
  setup do
    @team_membership = team_memberships(:one)
  end

  test "visiting the index" do
    visit team_memberships_url
    assert_selector "h1", text: "Team memberships"
  end

  test "should create team membership" do
    visit team_memberships_url
    click_on "New team membership"

    fill_in "Team", with: @team_membership.team_id
    fill_in "User", with: @team_membership.user_id
    click_on "Create Team membership"

    assert_text "Team membership was successfully created"
    click_on "Back"
  end

  test "should update Team membership" do
    visit team_membership_url(@team_membership)
    click_on "Edit this team membership", match: :first

    fill_in "Team", with: @team_membership.team_id
    fill_in "User", with: @team_membership.user_id
    click_on "Update Team membership"

    assert_text "Team membership was successfully updated"
    click_on "Back"
  end

  test "should destroy Team membership" do
    visit team_membership_url(@team_membership)
    accept_confirm { click_on "Destroy this team membership", match: :first }

    assert_text "Team membership was successfully destroyed"
  end
end
