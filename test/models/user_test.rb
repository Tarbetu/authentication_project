# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @user = User.create!(
      email: 'most_boring_user@boreismysoul.com',
      password: 'ayemborink',
      password_confirmation: 'ayemborink'
    )
  end

  test 'The Confirmation Token Should Expires in 10 Minutes' do
    assert_equal User::CONFIRMATION_TOKEN_EXPIRATION.in_minutes, 10.0
  end

  test 'The Password Reset Token Should Expires in 10 Minutes' do
    assert_equal User::PASSWORD_RESET_TOKEN_EXPIRATION.in_minutes, 10.0
  end

  test 'There should be an Email' do
    user = User.new(
      password: 'hakırboy666',
      password_confirmation: 'hakırboy666'
    )
    assert_not user.valid?
  end

  test 'Email should be in a lowercase form before saving' do
    worst_case_email = 'geCeLeRin_yaRjiCi@emesen.com'
    user = User.create!(
      email: worst_case_email,
      password: 'hakırboy666',
      password_confirmation: 'hakırboy666'
    )
    assert_not_equal user.email, worst_case_email
  end

  test 'Email must be in a valid form' do
    user = User.new(
      email: "Hi. Call me Ishmael. Some years ago, I'm tring to get an email account...",
      password: 'bestdockeruserever',
      password_confirmation: 'bestdockeruserever'
    )
    assert_not user.valid?
  end

  test 'There must be an password' do
    user = User.new(
      email: 'i_dont_know_what_is_password@kapisizkoy.com'
    )
    assert_not user.valid?
  end

  test 'Password confirmation is not really required' do
    user = User.new(
      email: 'is_this_login_form@confused.com',
      password: 'lalalala'
    )
    assert user.valid?
  end

  test 'When the user registered, they shall be unconfirmed' do
    assert @user.unconfirmed?
  end

  test 'User is able to generate a confirmation token' do
    assert @user.respond_to? 'generate_confirmation_token'
  end

  test 'User is able to generate a password reset token' do
    assert @user.respond_to? 'generate_password_reset_token'
  end

  test 'The user model is able to send a confirmation email' do
    assert_emails 1 do
      @user.send_confirmation_email!
    end
  end

  test 'The user model is able to send a password reset email' do
    assert_emails 1 do
      @user.send_password_reset_email!
    end
  end
end
