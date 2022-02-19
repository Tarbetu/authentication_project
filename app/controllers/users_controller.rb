# frozen_string_literal: true

# Controller for User model
# Check the User model comments
class UsersController < ApplicationController
  # @return [void]
  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_confirmation_email!
      redirect_to root_path, notice: 'Check your email for confirmation'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @return [void]
  def new
    @user = User.new
  end

  private

  # @return [ActionController::Parameters]
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
