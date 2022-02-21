# frozen_string_literal: true

require 'test_helper'

class ActiveSessionTest < ActiveSupport::TestCase
  setup do
    # @active_session = ActiveSession.new(
    #   user: @best_user_ever,
    #   ip_address: '192.168.0.1',
    #   user_agent: 'Mozilla/4.5 (compatible; HTTrack 3.0x; Windows 98)'
    # )
    @best_user_ever = users(:best_user_ever)
    @active_session = @best_user_ever.active_sessions.build
    @active_session.ip_address = '192.168.0.1'
    @active_session.user_agent = 'Mozilla/4.5 (compatible; HTTrack 3.0x; Windows 98)'
  end

  test 'It is valid if validations met' do
    assert @active_session.valid?
  end

  test 'It is invalid if there is no user' do
    @active_session.user = nil

    assert_not @active_session.valid?
  end

  # test 'It is invalid if there is no ip_address' do
  #   @session = @best_user_ever.active_sessions.build
  #   @session.user_agent = 'Mozilla/5 (undetecable; Ghost 0.0x; FBI_OS)'
  #   assert_not @session.valid?
  # end

  # test 'It is invalid if ip address does not look like an IP' do
  #   @session = @best_user_ever.active_sessions.build
  #   @session.ip_address = '666.13'
  #   @session.user_agent = 'Satanilla/13 (unbelievable; Satan 13x; Ubuntu Satanic Edition)'

  #   assert_not @session.valid?
  # end

  # test 'It is invalid if there is no user_agent' do
  #   @session = @best_user_ever.active_sessions.build
  #   @session.ip_address = '127.0.0.1'

  #   assert_not @session.valid?
  # end
end
