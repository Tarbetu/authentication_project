# frozen_string_literal: true

# Manages the cookies and sessions
# Check the authentication concern
class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  # @type [String]
  INCORRECT_MESSAGE = 'Correct your email or password'

  def create
    # @type [User, NilClass]
    @user = User.find_by(email: params[:user][:email].downcase)

    unless @user
      flash.now[:alert] = INCORRECT_MESSAGE
      render :new, status: :unproccesable_entity
      return
    end

    if @user.unconfirmed?
      redirect_to new_confirmation_path, alert: INCORRECT_MESSAGE
    elsif @user.authenticate(params[:user][:password])
      login @user
      redirect_to root_path, notice: signed_id
    else
      flash.now[:alert] = INCORRECT_MESSAGE
      render :new, status: :unproccesable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Signed out.'
  end

  def new; end
end
