# frozen_string_literal: true

# This controller provides CRUD actions for role
class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions_for_manage_users
  before_action :set_role, only: %i[edit update destroy]

  # @return [void]
  def new
    @role = Role.new
  end

  # @return [void]
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_back fallback_location: root_path, notice: 'Role was successfully created' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('roleCreatedMessage', partial: 'ok_message')
        end
      else
        format.html { render :new, status: :unprocessable_entity }

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('roleCreatedMessage', partial: 'err_message')
        end
      end
    end
  end

  # @return [void]
  def edit; end

  # @return [void]
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: :root_path, notice: 'This role is destroyed' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('roleUpdatedMessage', 'del_message')
      end
    end
  end

  # @return [void]
  def update
    respond_to do |format|
      if @role.update(role_params)
        User.cache_every_users_grant
        format.html { redirect_to role_url(@role), notice: 'Role was updated' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('roleUpdatedMessage', partial: 'ok_message')
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('roleUpdatedMessage', partial: 'err_message')
        end
      end
    end
  end

  # @return [void]
  def search
    respond_to do |format|
      format.turbo_stream do
        @roles = Role.where('name LIKE ?', "%#{params[:query]}%")

        render turbo_stream: turbo_stream.append(
          'roleResult', partial: 'result'
        )
      end
    end
  end

  private

  # @return [Role]
  def set_role
    @role = Role.find(params[:id])
  end

  # @return [ActionController::Parameters]
  def role_params
    params.require(:role).permit(:name, grant_ids: [])
  end
end
