class Team < ApplicationRecord
  has_many :projects
  belongs_to :user
  has_many :team_relationships
  has_many :members, through: :team_relationships, source: :user
  has_many :events
  has_many :todos
  has_many :reviews
end
