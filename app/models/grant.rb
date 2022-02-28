# frozen_string_literal: true

# Manages the permissions which used by User
class Grant < ApplicationRecord
  has_many :role_model_associations, dependent: :destroy
  has_many :roles, through: :role_model_association
  after_commit { Kredis.clear_all }
end
