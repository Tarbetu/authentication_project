# frozen_string_literal: true

require 'resolv'

# This model contains information about sessions
# A user may have multiply sessions
class ActiveSession < ApplicationRecord
  belongs_to :user

  has_secure_token :remember_token

  # validates :ip_address,
  #           format: {
  #             with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex)
  #           }
  # validates :user_agent, presence: true
end
