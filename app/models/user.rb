# frozen_string_literal: true

# The main thing on the application
# Every email written in lower case, thus we downcase before saving
# This model able to create confirmation and password reset token
# You might want to look at the related migrations comments.
class User < ApplicationRecord
  # @type [ActiveSupport::Duration]
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  # @type [ActiveSupport::Duration]
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

  # @type [String]
  MAILER_FROM_EMAIL = 'never_reply_plz@example.com'

  before_save :downcase_email

  has_secure_password

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  # @return [void]
  def confirm!
    update! confirmed_at: Time.now
  end

  # @return [Boolean]
  def confirmed?
    confirmed_at.present?
  end

  # @return [Boolean]
  def unconfirmed?
    !confirmed?
  end

  # @return [ActiveSupport::MessageVerifier]
  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  # @return [void]
  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  # @return [ActiveSupport::MessageVerifier]
  def generate_password_reset_token
    signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: :reset_password
  end

  # @return [ActiveSupport::MessageVerifier]
  def send_password_reset_email!
    password_reset_token = generate_confirmation_token
    UserMailer.password_reset(self, password_reset_token).deliver_now
  end

  private

  # @return [void]
  def downcase_email
    self.email = email.downcase
  end
end
