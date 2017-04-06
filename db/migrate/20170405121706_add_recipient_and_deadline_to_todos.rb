class AddRecipientAndDeadlineToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :recipient, :string
    add_column :todos, :deadline, :datetime
  end
end
