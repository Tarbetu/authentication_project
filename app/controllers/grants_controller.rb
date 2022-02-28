# frozen_string_literal: true

# This controller provides CRUD actions for Grants
class GrantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions_for_manage_users
  before_action :set_grant, only: %i[edit update destroy]

  # @return [void]
  def new
    @grant = Grant.new
  end

  # @return [void]
  def create
    @grant = Grant.new(grant_params)

    respond_to do |format|
      if @grant.save
        format.html { redirect_back fallback_location: root_path, notice: 'Grant was successfully created' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('grantCreatedMessage', partial: 'ok_message')
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('grantCreatedMessage', partial: 'err_message')
        end
      end
    end
  end

  # @return [void]
  def edit; end

  # @return [void]
  def update
    respond_to do |format|
      if @grant.update(grant_params)
        User.cache_every_users_grant

        format.html { redirect_to grant_url(@role), notice: 'Grant was updated' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('grantUpdatedMessage', partial: 'ok_message')
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('grantUpdatedMessage', partial: 'err_message')
        end
      end
    end
  end

  # @return [void]
  def destroy
    @grant.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: :root_path, notice: 'This role is deleted!' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('grantUpdatedMessage', 'del_message')
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

  # @return [Grant]
  def set_grant
    @grant = Grant.find(params[:id])
  end

  # @return [ActiveController::Parameters]
  def grant_params
    params.require(:grant).permit(:name, role_ids: [])
  end
end
