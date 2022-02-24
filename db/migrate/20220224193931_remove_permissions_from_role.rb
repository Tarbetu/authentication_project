# frozen_string_literal: true

class RemovePermissionsFromRole < ActiveRecord::Migration[7.0]
  def change
    remove_column :roles, :permissions, :integer
  end
end
