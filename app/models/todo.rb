class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :reviews
end
