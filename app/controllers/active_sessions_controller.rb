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
    @active.session.destroy

    unless current_user
      forget_active_session
      reset_session
      redirect_to root_path, notice: 'Signed out'
      return
    end

    # Ne accountu? Nereye yönlendiriyor bu?
    redirect_to users_path, notice: 'Session deleted'
  end
end
