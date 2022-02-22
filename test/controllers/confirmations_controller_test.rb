# frozen_string_literal: true

require 'test_helper'

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unconfirmed_email = 'hey_this_is_my_first_account@rookie.com'
    @unconfirmed_user = User.create!(
      email: @unconfirmed_email,
      password: 'Okay, Just give me the confirmation token',
      password_confirmation: 'Okay, Just give me the confirmation token'
    )

    @confirmed_email = 'i_am_getting_bored_when_i_write_these_tests@bored.com'
    @user = User.create!(
      email: @confirmed_email,
      password: '123456bored',
      password_confirmation: '123456bored',
      confirmed_at: Time.now
    )
  end

  test 'If user is authenticated, the user should redirected except the confirm page' do
    login @user

    get new_confirmation_path
    assert_redirected_to root_path
  end

  test 'If user is not authenticated, they can access the new confirmation page' do
    get new_confirmation_path
    assert_response :ok
  end

  test 'User is able to request confirmation token for unconfirmated users' do
    assert_emails 1 do
      post confirmations_path, params: {
        user: { email: @unconfirmed_email }
      }
      assert_equal flash[:notice], ConfirmationsController::OK_MESSAGE
    end
  end

  test 'User is not able to request confirmation token for confirmed user' do
    assert_no_emails do
      post confirmations_path, params: {
        user: { email: @confirmed_email }
      }
      assert_equal flash[:alert], ConfirmationsController::NOT_AVAILABLE_MESSAGE
    end
  end

  test 'User is not able to request confirmation for non-existing users' do
    assert_no_emails do
      post confirmations_path, params: {
        user: { email: 'the_no_one@the_voidness_itself.com' }
      }
      assert_equal flash[:alert], ConfirmationsController::NOT_AVAILABLE_MESSAGE
    end
  end

  test 'Anyone is able to confirm a user if they get to right token' do
    token = @unconfirmed_user.generate_confirmation_token

    get edit_confirmation_path(token)
    assert_redirected_to root_path
    assert_equal flash[:notice], ConfirmationsController::CONFIRMED_MESSAGE
  end

  test 'No one can confirm a user with an expired token' do
    token = @unconfirmed_user.generate_confirmation_token

    travel_to (User::CONFIRMATION_TOKEN_EXPIRATION + 1).from_now
    get edit_confirmation_path(token)
    assert_redirected_to new_confirmation_path
    assert_equal flash[:alert], ConfirmationsController::INVALID_MESSAGE
  end
end
