# frozen_string_literal: true

# This model contains information about sessions
# A user may have multiply sessions
class ActiveSession < ApplicationRecord
  belongs_to :user
end
