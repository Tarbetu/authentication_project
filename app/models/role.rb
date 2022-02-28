# frozen_string_literal: true

# Manages the status of the User
class Role < ApplicationRecord
  has_many :users
  has_many :role_model_associations, dependent: :destroy
  has_many :grants, through: :role_model_associations

  after_commit { Kredis.clear_all }
  before_destroy :save_the_users

  # This macro defines some methods which queries the grants of the role
  # They returns boolean
  # Note that this model does not queries the cache or reads cache
  # Example usage: admin.can_read?
  Grant.pluck(:name).each do |grant_name|
    define_method("can_#{grant_name}?") do
      grants.find_by(name: grant_name).present?
    end
  end

  private

  def save_the_users
    users.find_each do |user|
      user.role = Role.first
      user.save
    end
  end

  def cache_users_grant
    Kredis.clear_all

    User.cache_every_users_grant
  end
end
