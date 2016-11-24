require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:edvinas)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "user email should be present" do
    @user.email = ""
    assert @user.invalid?
  end

  test "user password should be present" do
    @user.password = ""
    assert @user.invalid?
  end

end
