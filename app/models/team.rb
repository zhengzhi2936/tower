# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#

class Team < ApplicationRecord
  validates_presence_of :name
  has_many :projects
  belongs_to :user
  has_many :events
  has_many :team_permissions
  after_commit :assion_team_permission
  def assion_team_permission
    TeamPermission.create([user_id: self.user.id, team_id: self.id, level: "owner"])
  end
end
