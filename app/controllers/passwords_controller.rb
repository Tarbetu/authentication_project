# frozen_string_literal: true

# This Controller manages the password resetting actions
class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  # @type [String]
  OK_MESSAGE = "If this user exists we've sent a email"
  # @type [String]
  CONFIRM_MESSAGE = 'First, confirm your email.'
  # @type [String]
  INVALID_MESSAGE = 'Invalid or expired token'

  # Forget password page
  # @return [void]
  def new; end

  # Creates new password token
  # @return [void]
  def create
    # @type [User, NilClass]
    @user = User.find_by(email: params[:user][:email].downcase)
    unless @user.present?
      redirect_to root_path, notice: OK_MESSAGE
      return
    end

    if @user.confirmed?
      @user.send_password_reset_email!
      redirect_to root_path, notice: OK_MESSAGE
    else
      redirect_to new_confirmations_path, alert: CONFIRM_MESSAGE
    end
  end

  # @return [void]
  def edit
    # @type [User, NilClass]
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
    if @user.nil?
      redirect_to new_password_path, alert: INVALID_MESSAGE
    elsif @user.unconfirmed?
      redirect_to new_confirmations_path, alert: CONFIRM_MESSAGE
    end
  end

  # It updates the user password
  # @return [void]
  def update
    # @type [User, NilClass]
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)

    unless @user
      flash.now[:alert] = INVALID_MESSAGE
      render :new, status: :unprocessable_entity
      return
    end

    if @user.unconfirmed?
      redirect_to new_confirmations_path, alert: CONFIRM_MESSAGE
    elsif @user.update(password_params)
      redirect_to new_sessions_path, notice: 'OK! Now you can login'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # @return [ActionController::Parameters]
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
