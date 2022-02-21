# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:best_user_ever)
  end

  test 'Anonymous users can see the sign up page' do
    get new_users_path
    assert_response :ok
  end

  test 'Signed in users should redirected if they try to access signup page' do
    login @user

    get new_users_path
    assert_redirected_to root_path
  end
end
