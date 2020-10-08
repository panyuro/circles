require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "zhangsaan", password: "111111", password_confirmation: "111111", email: "aa@qq.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should accept valid address" do
    @user.email = "1111"
    assert_not @user.valid?

    @user.email = "1111@qq.com"
    assert @user.valid?
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should downcase before save" do
    new_email = "AAZ@QQ.COM"
    @user.email = new_email
    @user.save
    assert_equal new_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should be secure" do
    assert @user.authenticate("111111")
    assert_not @user.authenticate("211111")
  end
end
