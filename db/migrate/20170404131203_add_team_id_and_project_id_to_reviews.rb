class AddTeamIdAndProjectIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :team_id, :integer
    add_column :reviews, :project_id, :integer
  end
end
