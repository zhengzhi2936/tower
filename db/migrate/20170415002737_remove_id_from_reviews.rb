class RemoveIdFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :team_id, :integer
    remove_column :reviews, :project_id, :integer
  end
end
