# frozen_string_literal: true

# Manages the permissions which handled by User
class Grant < ApplicationRecord
  has_many :role, through: :role_model_association
end
