# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#
# Indexes
#
#  index_projects_on_team_id  (team_id)
#  index_projects_on_user_id  (user_id)
#

class Project < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :todos
  has_many :events
  has_many :reviews
end
