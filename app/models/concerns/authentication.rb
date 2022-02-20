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

  # @return [void]
  def authenticate_user!
    redirect_to login_path, alert: 'You need to login to access that page.' unless user_signed_in?
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

  # @param user [User]
  # @return [void]
  def remember(user)
    user.regenerate_remember_token
    cookies.permanent.encrypted[:remember_token] = user.remember_token
  end

  # @param user [User]
  # @return [void]
  def forget(user)
    cookies.delete :remember_token
    user.regenerate_remember_token
  end

  private

  # @return [User, nil] The user which signed in now
  def current_user
    Current.user ||= if session[:current_user_id].present?
                       User.find(session[:current_user_id])
                     elsif cookies.permanent.encrypted[:remember_token].present?
                       User.find_by(
                         remember_token: cookies.permanent.encrypted[:remember_token]
                       )
                     end
  end

  # @return [Boolean]
  # Kontrol et!
  def user_signed_in?
    # Current.user.present?
    current_user.present?
  end
end
