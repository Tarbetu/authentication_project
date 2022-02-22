# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @confirmed_user_email = 'the_true_ahmet@reallytrue.com'
    @confirmed_user_password = '22IMSoTruEtHaTIUseAnStronKPaswördcCc11'
    @confirmed_user = User.create!(
      email: @confirmed_user_email,
      password: @confirmed_user_password,
      password_confirmation: @confirmed_user_password,
      confirmed_at: Time.now
    )

    @unconfirmed_user_email = 'mr_wrong@emailaccountfromoutlook.com'
    @unconfirmed_user_password = '12345becauseimwrong'
    @unconfirmed_user = User.create!(
      email: @unconfirmed_user_email,
      password: @unconfirmed_user_password,
      password_confirmation: @unconfirmed_user_password
    )
  end

  test "Authenticated users can't access the login page" do
    login @confirmed_user

    get new_sessions_path
    assert_redirected_to root_path
  end

  test 'Unconfirmed users accepted to the login page' do
    login @unconfirmed_user

    get new_sessions_path
    assert_response :ok
  end

  test 'Logged in user is able to logout with "deleting" sessions path' do
    login @confirmed_user

    delete sessions_path
    assert_redirected_to root_path
    assert_equal flash[:notice], 'Signed out.'
  end

  test 'When logout, it should delete an active session belongs to user' do
    login @confirmed_user

    assert_difference('@confirmed_user.active_sessions.count', -1) do
      delete sessions_path
    end
  end

  test 'Unauthenticated users can not log out' do
    delete sessions_path
    assert_redirected_to new_sessions_path
  end

  test 'User is able to login via sending post request to the sessions_path' do
    assert_difference '@confirmed_user.active_sessions.count', 1 do
      post sessions_path, params: {
        user: {
          email: @confirmed_user_email,
          password: @confirmed_user_password,
          remember_me: '0'
        }
      }

      assert_redirected_to root_path
      assert_equal flash[:notice], 'Signed in.'
      assert_not_nil current_user
    end
  end

  test 'The users which unconfirmed are redirected to confirmation path if they try to login' do
    assert_no_difference '@confirmed_user.active_sessions.count' do
      post sessions_path, params: {
        user: {
          email: @unconfirmed_user_email,
          password: @unconfirmed_user_password,
          remember_me: '0'
        }
      }

      assert_redirected_to new_confirmation_path
      assert_equal flash[:alert], SessionsController::INCORRECT_MESSAGE
      assert_nil current_user
    end
  end

  test 'If users sending wrong password, they are not able to login' do
    assert_no_difference '@confirmed_user.active_sessions.count' do
      post sessions_path, params: {
        user: {
          email: @confirmed_user_email,
          password: 'mYB4nKF0RC3SM3FOrCh4ng4MyP4sswörDEverYDaY'
        }
      }

      assert_response :unprocessable_entity
      assert_equal flash[:alert], SessionsController::INCORRECT_MESSAGE
      assert_nil current_user
    end
  end
end
