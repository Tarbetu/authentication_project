require "test_helper"

class GreeterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get greeter_index_url
    assert_response :success
  end
end
