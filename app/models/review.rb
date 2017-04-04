class Review < ApplicationRecord
  belongs_to :user
  belongs_to :todo
  has_many :events
  belongs_to :team
  belongs_to :project
end
