require "application_system_test_case"

class ServiceTypesTest < ApplicationSystemTestCase
  setup do
    @service_type = service_types(:one)
  end

  test "visiting the index" do
    visit service_types_url
    assert_selector "h1", text: "Service types"
  end

  test "should create service type" do
    visit service_types_url
    click_on "New service type"

    fill_in "Description", with: @service_type.description
    check "Is active" if @service_type.is_active
    check "Is billable" if @service_type.is_billable
    fill_in "Team", with: @service_type.team_id
    click_on "Create Service type"

    assert_text "Service type was successfully created"
    click_on "Back"
  end

  test "should update Service type" do
    visit service_type_url(@service_type)
    click_on "Edit this service type", match: :first

    fill_in "Description", with: @service_type.description
    check "Is active" if @service_type.is_active
    check "Is billable" if @service_type.is_billable
    fill_in "Team", with: @service_type.team_id
    click_on "Update Service type"

    assert_text "Service type was successfully updated"
    click_on "Back"
  end

  test "should destroy Service type" do
    visit service_type_url(@service_type)
    accept_confirm { click_on "Destroy this service type", match: :first }

    assert_text "Service type was successfully destroyed"
  end
end
