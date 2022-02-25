# frozen_string_literal: true

# Manages the permissions which used by User
class Grant < ApplicationRecord
  has_many :role_model_associations
  has_many :roles, through: :role_model_association
end
