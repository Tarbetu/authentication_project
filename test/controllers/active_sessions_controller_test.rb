# frozen_string_literal: true

require 'test_helper'

class ActiveSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: 'deregeliyordere@yaleleyalele.ya',
      password: 'Dereyi kurutmuşlar pi',
      password_confirmation: 'Dereyi kurutmuşlar pi',
      confirmed_at: Time.now
    )
  end

  test 'Non-authorized users are not able to logout' do
    delete active_session_path(0)
    assert_redirected_to new_sessions_path
  end

  test 'Authorized users can logout with "deleting" active_session_path' do
    login @user

    assert_difference 'ActiveSession.count', -1 do
      delete active_session_path(@user.active_sessions.last)
      assert_redirected_to root_path
      assert_equal flash[:notice], 'Signed out'
      assert_nil current_user
    end
  end

  test 'Authorized users can logout their other sessions' do
    login @user
    @user.active_sessions.create!

    assert_difference 'ActiveSession.count', -1 do
      delete active_session_path(@user.active_sessions.last)
      assert_redirected_to edit_users_path
      assert_not_nil current_user
    end
  end

  test 'Non-authorized users are not able to access "destroy_all_active_sessions_path"' do
    delete destroy_all_active_sessions_path
    assert_redirected_to new_sessions_path
  end

  test 'User can destroy their sessions with a single command' do
    login @user
    9.times { @user.active_sessions.create! }

    assert_difference 'ActiveSession.count', -10 do
      delete destroy_all_active_sessions_path
      assert_redirected_to root_path
      assert_equal flash[:notice], 'Signed out.'
    end
  end
end
