require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should not create user" do
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {
          username: "",
          email: "wwww@qq.com",
          password: 'foo',
          password_confirmation: 'foo'
      }}
      assert_template 'users/new'
      assert_select 'div.alert-danger'
    end
  end

  test "should create user" do
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
          username: "sss",
          email: "wwww@qq.com",
          password: 'foo000',
          password_confirmation: 'foo000'
      }}
      follow_redirect! while redirect?
      assert_template 'sessions/new'
      # assert_not flash.FIll_IN
      # assert_redirected_to new_session_path
    end
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end
end
