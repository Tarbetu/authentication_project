# frozen_string_literal: true

class RemoveRoleIdFromGrants < ActiveRecord::Migration[7.0]
  def change
    remove_column :grants, :role_id, :integer
  end
end
