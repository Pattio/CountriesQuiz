require 'test_helper'

class CountriesControllerTest < ActionDispatch::IntegrationTest
  test "should get all countries list" do
    get countries_url
    assert_response :success
  end

  test "should get country" do
    get country_url 1
    assert_response :success
  end

  test "should search for a country" do
    get "/countries", params: { search: "United Kingdom" }
    assert_response :success
  end

end
