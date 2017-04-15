# == Schema Information
#
# Table name: team_owners
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeamOwner < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
