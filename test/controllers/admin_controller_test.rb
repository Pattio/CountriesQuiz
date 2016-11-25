require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "redirect user if not logged in" do
    get dashboard_url
    assert_response :redirect
  end

end
