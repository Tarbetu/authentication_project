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
    active_session = user.active_sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.ip
    )
    session[:current_active_session_id] = active_session.id
  end

  # @return [void]
  def logout
    active_session = ActiveSession.find(session[:current_active_session_id])
    reset_session
    active_session.destroy! if active_session.present?
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
                       ActiveSession.find(session[:current_active_session_id]).user
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

  # Note to myself: the local? method returns information
  # about is this request is comes from ajax or not
  # @return [void]
  def store_location
    session[:user_return_to] = request.original_url if request.get? && request.lcoal?
  end
end
