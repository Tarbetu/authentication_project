# frozen_string_literal: true

# Controller for User model
# Check the User model comments
class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit destroy update]
  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :set_current_user, only: %i[update edit]
  # @return [void]
  def create
    @user = User.new(create_user_params)
    @user.role = Role.find_by(name: 'Peasant')

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

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: 'Farewell, dear deleted user.'
  end

  def edit; end

  def update
    unless @user.authenticate(params[:user][:current_password])
      flash.now[:error] = 'Incorrect Password'
      render :edit, status: :unprocessable_entity
      return
    end

    if @user.update(update_user_params)
      if params[:user][:unconfirmed_email].present?
        @user.send_confirmation_email!
        redirect_to root_path, notice: 'Check your email confirmation'
      else
        redirect_to root_path, notice: 'User updated'
      end
      return
    end

    render :edit, status: :unprocessable_entity
  end

  private

  # @return [void]
  def set_current_user
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
  end

  # @return [ActionController::Parameters]
  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # @return [ActionController::Parameters]
  def update_user_params
    params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation,
      :unconfirmed_email
    )
  end
end
