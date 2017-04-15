class AddIndexToAllTheModel < ActiveRecord::Migration[5.0]
  def change
    add_index :events, :user_id
    add_index :events, :team_id
    add_index :events, :project_id
    add_index :events, :todo_id
    add_index :events, :review_id
    add_index :projects, :user_id
    add_index :projects, :team_id
    add_index :reviews, :user_id
    add_index :reviews, :todo_id
    add_index :teams, :user_id
  end
end
