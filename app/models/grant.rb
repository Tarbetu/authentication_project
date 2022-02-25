# frozen_string_literal: true

# Manages the permissions which used by User
class Grant < ApplicationRecord
  has_many :role, through: :role_model_association
end
