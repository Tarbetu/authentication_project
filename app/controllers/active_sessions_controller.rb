# frozen_string_literal: true

# This controller manages the sessions which saved by active session model
class ActiveSessionsController < ApplicationController
  before_action :authenticate_user!

  # @return [void]
  def destroy_all
    forget_active_session
    current_user.active_sessions.destroy_all
    reset_session

    redirect_to root_path, notice: 'Signed out.'
  end

  # @return [void]
  def destroy
    @active_session = current_user.active_sessions.find(params[:id])
    @active_session.destroy

    if current_user
      redirect_to edit_user_path(current_user), notice: 'Session deleted'
    else
      forget_active_session
      reset_session
      redirect_to root_path, notice: 'Signed out'
    end
  end
end
