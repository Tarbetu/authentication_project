class CreateRoleModelAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :role_model_associations do |t|
      t.references :role, null: false, foreign_key: true
      t.references :grant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
