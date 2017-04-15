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
