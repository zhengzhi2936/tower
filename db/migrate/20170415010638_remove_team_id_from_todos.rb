class RemoveTeamIdFromTodos < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :team_id, :integer
    add_index :todos, :user_id
    add_index :todos, :project_id
  end
end
