require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
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
    assert_difference 'User.count' do
      post signup_path, params: {user: {
          username: "sss",
          email: "wwww@qq.com",
          password: 'foo000',
          password_confirmation: 'foo000'
      }}
    end
  end
end
