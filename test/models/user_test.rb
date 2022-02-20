# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

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

  test 'Email should be downcase before saving' do
    worst_case_email = 'geCeLeRin_yaRjiCi@emesen.com'
    user = User.new(
      email: worst_case_email,
      password: 'hakırboy666',
      password_confirmation: 'hakırboy666'
    )
    user.valid?
    assert_not_equal worst_case_email, user.email
  end

  test 'Email should be in a valid form' do
    user = User.new(
      email: "Hi. Call me Ishmael. Some years ago, I'm tring to get an email...",
      password: 'bestdockeruserever',
      password_confirmation: 'bestdockeruserever'
    )
    assert_not user.valid?
  end

  test 'There should be an password' do
    user = User.new(
      email: 'i_dont_know_what_is_password@kapisizkoy.com'
    )
    assert_not user.valid?
  end

  test 'Password confirmation is required' do
    user = User.new(
      email: 'is_this_login_form@confused.com',
      password: 'lalalala'
    )
    assert_not user.valid?
  end

  test 'Password confirmation should match with password' do
    user = User.new(
      email: 'i_love_ruby@rails.com',
      password: "Because i can't stand the Node.js thing",
      password_confirmation: "Really, i had tried to use Node but i can't"
    )
    assert_not user.valid?
  end
end
