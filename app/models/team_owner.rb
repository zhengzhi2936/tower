class TeamOwner < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
