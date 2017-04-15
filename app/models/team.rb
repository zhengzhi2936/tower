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
  has_many :team_relationships
  has_many :members, through: :team_relationships, source: :user
  has_many :team_owners
  has_one :owner, through: :team_owners, source: :user
  has_many :events
end
