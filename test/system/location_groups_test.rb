require "application_system_test_case"

class LocationGroupsTest < ApplicationSystemTestCase
  setup do
    @location_group = location_groups(:one)
  end

  test "visiting the index" do
    visit location_groups_url
    assert_selector "h1", text: "Location groups"
  end

  test "should create location group" do
    visit location_groups_url
    click_on "New location group"

    fill_in "Description", with: @location_group.description
    click_on "Create Location group"

    assert_text "Location group was successfully created"
    click_on "Back"
  end

  test "should update Location group" do
    visit location_group_url(@location_group)
    click_on "Edit this location group", match: :first

    fill_in "Description", with: @location_group.description
    click_on "Update Location group"

    assert_text "Location group was successfully updated"
    click_on "Back"
  end

  test "should destroy Location group" do
    visit location_group_url(@location_group)
    accept_confirm { click_on "Destroy this location group", match: :first }

    assert_text "Location group was successfully destroyed"
  end
end
