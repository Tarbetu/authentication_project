# frozen_string_literal: true

# The main thing on the application
# Every email written in lower case, thus we downcase before saving
# You might want to look at the related migrations comments.
class User < ApplicationRecord
  # @type [ActiveSupport::Duration]
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  before_save :downcase_email

  has_secure_password

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  # @return [void]
  def confirm!
    @confirmed_at = Time.current
    save!
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

  private

  # @return [void]
  def downcase_email
    self.email = email.downcase
  end
end
