# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # These helpers are copied from
  # https://github.com/stevepolitodesign/rails-authentication-from-scratch/blob/main/test/test_helper.rb
  def current_user
    if session[:current_active_session_id].present?
      ActiveSession.find_by(id: session[:current_active_session_id])&.user
    elsif cookies[:remember_token].present?
      ActiveSession.find_by(remember_token: cookies[:remember_token])&.user
    end
  end

  def login(user, remember_user: nil)
    post sessions_path, params: {
      user: {
        email: user.email,
        password: user.password,
        remember_me: remember_user == true ? 1 : 0
      }
    }
  end

  def logout
    session.delete(:current_active_session_id)
  end
end
