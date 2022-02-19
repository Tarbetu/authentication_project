# frozen_string_literal: true

# :nodoc:
class UserMailer < ApplicationMailer
  # @return [void]
  # @param user [User]
  # @param confirmation_token [ActiveSupport::MessageVerifier]
  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: 'About Confirmation'
  end
end
