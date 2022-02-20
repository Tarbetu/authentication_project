# frozen_string_literal: true

# For email confirmations of User
class ConfirmationsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]

  # @return [void]
  def create
    # @type [User]
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      redirect_to root_path, notice: 'Check the email for confirmations'
    else
      redirect_to new_confirmation_path, alert: 'Confirmation is not available for this user'
    end
  end

  # @return [void]
  def edit
    # @type [User]
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present? && @user.unconfirmed_or_reconfirming?
      if @user.confirm!
        login @user
        redirect_to root_path, notice: 'Confirmed!'
      end
    else
      redirect_to new_confirmation_path, alert: 'Invalid token'
    end
  end

  # @return [void]
  def new
    # @type [User]
    @user = User.new
  end
end
