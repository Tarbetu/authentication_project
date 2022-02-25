# frozen_string_literal: true

# Manages the status of the User
class Role < ApplicationRecord
  has_many :users
  has_many :role_model_associations
  has_many :grants, through: :role_model_associations

  # @return [Boolean]
  def any_grants?; end

  def can_read?; end

  def can_delete_and_edit?; end

  def can_manage_users?; end
end
