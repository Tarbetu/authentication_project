# frozen_string_literal: true

# For email confirmations of User
class ConfirmationsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]

  # @type [String]
  OK_MESSAGE = 'Check the email for confirmations'
  # @type [String]
  CONFIRMED_MESSAGE = 'Confirmed!'
  # @type [String]
  INVALID_MESSAGE = 'Invalid token'
  # @type [String]
  NOT_AVAILABLE_MESSAGE = 'Confirmation is not available for this user'

  # @return [void]
  def create
    # @type [User]
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      redirect_to root_path, notice: OK_MESSAGE
    else
      redirect_to new_confirmation_path, alert: NOT_AVAILABLE_MESSAGE
    end
  end

  # @return [void]
  def edit
    # @type [User]
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present? && @user.unconfirmed_or_reconfirming?
      if @user.confirm!
        login @user
        redirect_to root_path, notice: CONFIRMED_MESSAGE
      end
    else
      redirect_to new_confirmation_path, alert: INVALID_MESSAGE
    end
  end

  # @return [void]
  def new
    # @type [User]
    @user = User.new
  end
end
