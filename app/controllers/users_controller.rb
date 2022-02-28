# frozen_string_literal: true

# Controller for User model
# Check the User model comments
class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit destroy update]
  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :set_current_user, only: %i[update edit]
  before_action :check_permissions_for_manage_users, only: %i[update_role]

  # @return [void]
  def show
    @user = User.find(params[:id])
  end

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
    @user = User.find(params[:id])
    if @user == current_user
      current_user.destroy
      reset_session
      redirect_to root_path, notice: 'Farewell, dear deleted user.'
    else
      @user.destroy
      flash[:notice] = 'You delete this user, you monster!'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit; end

  def update
    unless @user.authenticate(params[:user][:current_password])
      flash.now[:error] = 'Incorrect Password'
      # render :edit, status: :unprocessable_entity
      render(
        turbo_stream: turbo_stream.update(
          'user-edit',
          partial: 'users/user',
          locals: {
            user: @user
          }
        )
      )
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

  # @return [void]
  def update_role
    @user = User.find(params[:id])

    @user.role = Role.find_by(name: params[:role_name])

    if @user.save
      @user.cache_grants
      redirect_to user_url(@user), notice: 'This users role successfully updated!'
    else
      flash[:alert] = "This user can't be updated the wanted role"
      render :show, status: :unprocessable_entity
    end
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
