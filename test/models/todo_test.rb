# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  aasm_state  :string           default("todo_created")
#  recipient   :string
#  deadline    :datetime
#
# Indexes
#
#  index_todos_on_aasm_state  (aasm_state)
#  index_todos_on_project_id  (project_id)
#  index_todos_on_user_id     (user_id)
#

require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
