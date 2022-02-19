# frozen_string_literal: true

# This concern contains methods about session activities
# It's better than filling everything in ApplicationController
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  # @param user [User] The user which logins to
  # @return [void]
  def login(user)
    reset_session
    session[:current_user_id] = user.id
  end

  # @return [void]
  def logout
    reset_session
  end

  # @return [void]
  def redirect_if_authenticated
    redirect_to root_path, alert: 'Already signed in' if user_signed_in?
  end

  private

  # @return [User, nil] The user which signed in now
  def current_user
    Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  # @return [Boolean]
  def user_signed_in?
    Current.user.present?
  end
end
