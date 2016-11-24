require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:edvinas)
  end

  test "should redirect to login if user is not logged in" do
    get root_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "user can login" do
    sign_in @user
    assert_response :success
  end

end
