# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: 'i_write_this_tests_at_midnight@sleepless.no',
      password: '12:00am',
      password_confirmation: '12:00am',
      confirmed_at: Time.now
    )
    @unconfirmed_user = User.create!(
      email: 'i_cant_access_my_email@neveremail.no',
      password: 'ihateemails',
      password_confirmation: 'ihateemails'
    )
    @token = @user.generate_password_reset_token
  end

  test 'Registered users must be redirected into root path' do
    login @user

    get new_password_path(@token)
    assert_redirected_to root_path
  end

  test 'Anonymous users can access password resetting form' do
    get new_password_path(@token)
    assert_response :ok
  end

  test 'Anonymous users can get password resetting tokens by emails' do
    token = @user.generate_password_reset_token

    assert_emails 1 do
      post passwords_path(token), params: {
        user: {
          email: @user.email
        }
      }
    end
  end

  test "If requested user isn't confirmed yet, they can't password reset token" do
    post passwords_path(@token), params: {
      user: {
        email: @unconfirmed_user.email
      }
    }

    assert_redirected_to new_confirmation_path
    assert_equal flash[:alert], PasswordsController::CONFIRM_MESSAGE
  end

  test 'User can access change password page with the valid token' do
    token = @user.generate_password_reset_token

    get edit_password_path(token)
    assert_response :ok
  end

  test "User can't access change password page with invalid token" do
    get edit_password_path('Oha saat 1-40 olmuş hala test yazıyorum')
    assert_redirected_to new_password_path
    assert_equal flash[:alert], PasswordsController::INVALID_MESSAGE
  end

  test 'Unconfirmed users redirected into confirm token path' do
    token = @unconfirmed_user.generate_password_reset_token

    get edit_password_path(token)
    assert_redirected_to new_confirmation_path
    assert_equal flash[:alert], PasswordsController::CONFIRM_MESSAGE
  end

  test 'Password tokens are valid only for some minutes' do
    token = @user.generate_password_reset_token

    travel_to (User::PASSWORD_RESET_TOKEN_EXPIRATION + 1).from_now
    get edit_password_path(token)
    assert_redirected_to new_password_path
    assert_equal flash[:alert], PasswordsController::INVALID_MESSAGE
  end

  test 'User is able to update password with "putting" params to password_path' do
    token = @user.generate_password_reset_token

    put password_path(token), params: {
      user: {
        password: 'bestpasswordever',
        password_confirmation: 'bestpasswordever'
      }
    }

    assert_redirected_to new_sessions_path
    assert_equal flash[:notice], 'OK! Now you can login'
  end

  test 'Invalid tokens should be ignored' do
    put password_path('lalala i am a hekır'), params: {
      user: {
        password: 'hekhekhek',
        password_confirmation: 'hekhekhek'
      }
    }

    assert_response :unprocessable_entity
    assert_equal flash.now[:alert], PasswordsController::INVALID_MESSAGE
  end

  test 'Unconfirmed users should be redirected to the confirmation page' do
    token = @unconfirmed_user.generate_password_reset_token

    put password_path(token), params: {
      user: {
        password: 'I hate confirmations',
        password_confirmation: 'I hate confirmations'
      }
    }

    assert_redirected_to new_confirmation_path
    assert_equal flash[:alert], PasswordsController::CONFIRM_MESSAGE
  end
end
