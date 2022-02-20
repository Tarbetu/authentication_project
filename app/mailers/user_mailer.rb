# frozen_string_literal: true

# This class manages the emails about User activations
# Like confirmation and password reset
# The tokens generated in User model
# Look at the User model for more information
class UserMailer < ApplicationMailer
  # @return [void]
  # @param user [User]
  # @param confirmation_token [ActiveSupport::MessageVerifier]
  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: 'About Confirmation'
  end

  # @return [void]
  # @param user [User]
  # @param confirmation_token [ActiveSupport::MessageVerifier]
  def password_reset(user, password_reset_token)
    @user = user
    @password_reset_token = password_reset_token

    mail to: @user.email, subject: 'About forgetting your password. Pff'
  end
end
