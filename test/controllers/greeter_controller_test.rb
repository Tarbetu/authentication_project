# frozen_string_literal: true

require 'test_helper'

class GreeterControllerTest < ActionDispatch::IntegrationTest
  test 'Everyone can access the main page' do
    get greeter_index_path
    assert_response :ok
  end
end
