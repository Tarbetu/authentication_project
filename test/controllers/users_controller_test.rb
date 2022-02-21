# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: 'i_am_going_to_tired_with_these_tests@testsaretiring.com',
      password: '1234567',
      password_confirmation: '1234567',
      confirmed_at: Time.now
    )

    @params = {
      user: {
        email: 'i_take_accounts_repeatly@repeat.it',
        password: '1234567',
        password_confirmation: '1234567'
      }
    }
  end

  test 'Anonymous users can see the sign up page' do
    get new_users_path
    assert_response :ok
  end

  test 'Registered users should redirected if they try to access signup page' do
    login @user

    get new_users_path
    assert_redirected_to root_path
  end

  test 'Creating user requests from registered user should be ignored' do
    login @user

    assert_no_difference 'User.count' do
      post users_path, params: @params
    end
  end

  test 'Creating user requests from anonymous user should be processed.' do
    assert_difference 'User.count', 1 do
      post users_path, params: @params
    end
  end

  test 'Creating user should send a email' do
    assert_emails 1 do
      post users_path, params: @params
    end
  end

  test 'If password_confirmation is wrong, creating user request should be denied' do
    test_params = @params
    test_params[:user][:password_confirmation] = 'lölölö'
    assert_no_difference 'User.count' do
      post users_path, params: test_params
    end
  end

  test 'If User model validations violated, user must not created' do
    violated_params = @params
    violated_params[:user][:email] = 'I love Violets!'
    assert_no_emails do
      assert_no_difference('User.count') { post users_path, params: violated_params }
    end
  end

  test 'Registered users can access to their user edit page' do
    login @user

    get edit_users_path
    assert_response :ok
  end

  test "Anonymous users can't update their user informations" do
    put users_path, params: @params

    assert_redirected_to new_sessions_path
  end

  test 'If user change their email, they should get an reconfirmation email' do
    login @user

    assert_emails 1 do
      put users_path, params: {
        user: {
          unconfirmed_email: 'new_cool_email@coolestemail.com',
          current_password: '1234567'
        }
      }
    end
  end

  test 'If user gives a wrong "current" password, controller should deny it' do
    assert_no_emails do
      put users_path, params: {
        user: {
          password: '555',
          password_confirmation: '555',
          current_password: 'Of course not this!'
        }
      }
    end
  end

  test 'Anonymous users should redirect if they try to access user edit page' do
    get edit_users_path
    assert_redirected_to new_sessions_path
  end

  test 'Destroy path... Shall destroy the user and gives the sorrowful message' do
    login @user

    delete users_path
    assert_redirected_to root_path
    assert_equal flash[:notice], 'Farewell, dear deleted user.'
  end

  test "Anonymous users can't delete themselves." do
    delete users_path

    assert_redirected_to new_sessions_path
  end
end
