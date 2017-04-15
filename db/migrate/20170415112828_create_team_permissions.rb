class CreateTeamPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :team_permissions do |t|
      t.integer :user_id, :index => true
      t.integer :team_id, :index => true
      t.string :level

      t.timestamps
    end
  end
end
