# == Schema Information
#
# Table name: team_relationships
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TeamRelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
