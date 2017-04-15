# == Schema Information
#
# Table name: team_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_team_permissions_on_team_id  (team_id)
#  index_team_permissions_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe TeamPermission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
