# frozen_string_literal: true

class RemoveUserIdFromRoles < ActiveRecord::Migration[7.0]
  def change
    remove_column :roles, :user_id
  end
end
