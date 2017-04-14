class Assignment < ApplicationRecord
  belongs_to :origin_executor, class_name: "User", optional: true
  belongs_to :new_executor, class_name: "User", optional: true
  attr_accessor :origin_executor_email, :new_executor_email
  belongs_to :todo
end
