require 'rails_helper'


  RSpec.describe Todo, type: :controller do
    before do
      @user = User.create!(:email => "123@123", :password => "123456")
      @todo = Todo.new(:title => "1234", :description => "1234", :recipient => "a", :deadline => "2018-04-06 05:52:00 UTC", :team => @team, :project => @project, :user => @user)
      @team = Team.new(:name => "1", :user => @user)
      @project = Project.new(:title => "123", :user => @user, :team => @team)
      @event = @todo.events.build
    end
