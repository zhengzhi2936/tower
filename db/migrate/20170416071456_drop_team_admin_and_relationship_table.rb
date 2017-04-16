class DropTeamAdminAndRelationshipTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :team_owners
    drop_table :team_relationships
  end
end
