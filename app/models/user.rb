# frozen_string_literal: true

# The main thing on the application
# Every email written in lower case, thus we downcase before saving
# This model able to create confirmation and password reset token
# You might want to look at the related migrations comments.
class User < ApplicationRecord
  attr_accessor :current_password

  # @type [ActiveSupport::Duration]
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  # @type [ActiveSupport::Duration]
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

  # @type [String]
  MAILER_FROM_EMAIL = 'never_reply_plz@example.com'

  before_save :downcase_email
  before_save :downcase_unconfirmed_email

  has_secure_password

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

  # @return [Boolean, NilClass]
  def confirm!
    return false unless unconfirmed_or_reconfirming? || update(email: unconfirmed_email, unconfirmed_email: nil)

    update! confirmed_at: Time.now
  end

  # @return [#to_s]
  def confirmable_email
    return email unless unconfirmed_email.present?

    unconfirmed_email
  end

  # @return [Boolean]
  def confirmed?
    confirmed_at.present?
  end

  # @return [Boolean]
  def reconfirming?
    unconfirmed_email.present?
  end

  # @return [Boolean]
  def unconfirmed_or_reconfirming?
    unconfirmed? || reconfirming?
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

  # @return [void]
  def downcase_unconfirmed_email
    return if unconfirmed_email.nil?

    self.unconfirmed_email = unconfirmed_email.downcase
  end
end
