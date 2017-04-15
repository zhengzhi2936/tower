# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  action     :string
#  user_id    :integer
#  team_id    :integer
#  project_id :integer
#  todo_id    :integer
#  review_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string
#  eventable  :string
#
# Indexes
#
#  index_events_on_project_id  (project_id)
#  index_events_on_review_id   (review_id)
#  index_events_on_team_id     (team_id)
#  index_events_on_todo_id     (todo_id)
#  index_events_on_user_id     (user_id)
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
