# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  aasm_state  :string           default("todo_created")
#  recipient   :string
#  deadline    :datetime
#
# Indexes
#
#  index_todos_on_aasm_state  (aasm_state)
#  index_todos_on_project_id  (project_id)
#  index_todos_on_user_id     (user_id)
#

class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :reviews
  has_many :events
  has_one :assignment, :dependent => :destroy
  include AASM

  aasm do
    state :todo_created, initial: true
    state :received
    state :finished
    state :todo_canceled

  event :receive_todo do
    transitions from: :todo_created, to: :received
  end

  event :finish_todo do
    transitions from: [:todo_created, :received], to: :finished
  end

  event :reopen_todo do
    transitions from: :finished, to: :todo_created
  end

  event :cancel_todo do
    transitions from: [:todo_created, :received, :finished], to: :todo_canceled
  end

  event :renew_todo do
    transitions from: :todo_canceled, to: :todo_created
  end
end
end
