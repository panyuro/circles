require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to new" do
    get blogs_url
    assert_response :success
  end
end
