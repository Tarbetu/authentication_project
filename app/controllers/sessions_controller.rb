# frozen_string_literal: true

# Manages the cookies and sessions
# Check the authentication concern
class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  # @type [String]
  INCORRECT_MESSAGE = 'Correct your email or password'

  # @type [void]
  def create
    # @type [User, NilClass]
    @user = User.authenticate_by(
      email: params[:user][:email].downcase,
      password: params[:user][:password]
    )

    unless @user
      flash.now[:alert] = INCORRECT_MESSAGE
      render :new, status: :unprocessable_entity
      return
    end

    if @user.unconfirmed?
      redirect_to new_confirmation_path, alert: INCORRECT_MESSAGE
    else
      after_login_path = session[:user_return_to] || root_path
      login @user
      remember(@user) if params[:user][:remember_me] == '1'
      redirect_to after_login_path, notice: 'Signed in.'
    end
  end

  # @type [void]
  def destroy
    forget(current_user)
    logout
    redirect_to root_path, notice: 'Signed out.'
  end

  def new; end
end
