class AddEventableToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :eventable, :string
  end
end
