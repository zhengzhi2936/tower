# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  todo_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reviews_on_todo_id  (todo_id)
#  index_reviews_on_user_id  (user_id)
#

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :todo, :optional => true
  has_many :events
end
