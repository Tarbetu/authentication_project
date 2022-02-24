# frozen_string_literal: true

class CreateRolesGrants < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_grants, id: false do |t|
      t.references :role, null: false, foreign_key: true
      t.references :grant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
