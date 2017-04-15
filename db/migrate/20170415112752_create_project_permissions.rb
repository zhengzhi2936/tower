class CreateProjectPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :project_permissions do |t|
      t.integer :user_id, :index => true
      t.integer :project_id, :index => true
      t.string :level

      t.timestamps
    end
  end
end
