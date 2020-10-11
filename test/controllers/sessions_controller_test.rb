require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete logout_path(@user)
    end

    assert_redirected_to users_url
  end
end
