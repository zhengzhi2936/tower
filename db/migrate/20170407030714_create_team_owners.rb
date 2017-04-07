class CreateTeamOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :team_owners do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
