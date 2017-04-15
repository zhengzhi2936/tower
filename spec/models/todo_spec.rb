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

require 'rails_helper'


  RSpec.describe Todo, type: :model do

  before do
    @todo = Todo.new(:title => "1234", :description => "1234")
  end

      it 'should be an initial state 1' do
        # Check for @vehicle.parked? to be true
        expect(@todo.aasm_state).to eq("todo_created")
      end
      it 'should be an initial state 2' do
        @todo.aasm_state = "finished"
        @todo.reopen_todo
        expect(@todo.aasm_state).to eq("todo_created")
      end
      it 'should be an initial state 3' do
        @todo.aasm_state = "todo_canceled"
        @todo.renew_todo
        expect(@todo.aasm_state).to eq("todo_created")
      end

      it "should be a received state" do
        @todo.receive_todo
        expect(@todo.aasm_state).to eq("received")
      end

      it "should be a finished state 1" do
        @todo.finish_todo
        expect(@todo.aasm_state).to eq("finished")
      end
      it "should be a finished state 2" do
        @todo.aasm_state = "received"
        @todo.finish_todo
        expect(@todo.aasm_state).to eq("finished")
      end

      it "should be a todo_canceled state 1" do
        @todo.aasm_state = "todo_created"
        @todo.cancel_todo
        expect(@todo.aasm_state).to eq("todo_canceled")
      end
      it "should be a todo_canceled state 2" do
        @todo.aasm_state = "received"
        @todo.cancel_todo
        expect(@todo.aasm_state).to eq("todo_canceled")
      end
      it "should be a todo_canceled state 3" do
        @todo.aasm_state = "finished"
        @todo.cancel_todo
        expect(@todo.aasm_state).to eq("todo_canceled")
      end
end
