require 'rails_helper'


  RSpec.describe Event, type: :model do

    before do
      @user = User.create!(:email => "123@123", :password => "123456")
      @todo = Todo.new(:title => "1234", :description => "1234", :recipient => "a", :deadline => "2018-04-06 05:52:00 UTC", :team => @team, :project => @project, :user => @user)
      @team = Team.new(:name => "1", :user => @user)
      @project = Project.new(:title => "123", :user => @user, :team => @team)
      @event = @todo.events.build
    end
  context "todo" do

    it "should be create todo.title event" do
      @event.create_event!(@todo)
      expect(@event.action).to eq("建立了#{@todo.title}任务！")
    end
    it "should be update todo.title event" do
      @event.update_event!(@todo)
      expect(@event.action).to eq("更新了#{@todo.title}任务！")
    end
    it "should be destroy todo.title event" do
      @event.destroy_event!(@todo)
      expect(@event.action).to eq("删除了#{@todo.title}任务！")
    end
    it "should be receive todo.title event" do
      @event.receive_event!(@todo)
      expect(@event.action).to eq("接受了#{@todo.title}任务！")
    end
    it "should be finish todo.title event" do
      @event.finish_event!(@todo)
      expect(@event.action).to eq("完成了#{@todo.title}任务！")
    end
    it "should be reopen todo.title event" do
      @event.reopen_event!(@todo)
      expect(@event.action).to eq("取消领取了#{@todo.title}任务！")
    end
    it "should be cancel todo.title event" do
      @event.cancel_event!(@todo)
      expect(@event.action).to eq("取消了#{@todo.title}任务！")
    end
    it "should be renew todo.title event" do
      @event.renew_event!(@todo)
      expect(@event.action).to eq("恢复了#{@todo.title}任务！")
    end
    it "should be assign_people_event todo.title event" do
      @event.assign_people_event!(@todo)
      expect(@event.action).to eq("指派了#{@todo.title}任务给#{@todo.recipient}")
    end
    it "should be assign_time_event todo.title event" do
      @event.assign_time_event!(@todo)
      expect(@event.action).to eq("指派了#{@todo.title}任务最后完成日期#{@todo.deadline}")
    end
  end
  context "review" do
    before do
      @review = Review.new(:content => "1234", :todo => @todo, :team => @team, :project => @project, :user => @user )
      @event = @review.events.build
    end
    it "should be create review.title event" do
      @event.create_review!(@review)
      expect(@event.action).to eq("评论了#{@review.todo.title}任务！")
    end
    it "should be update review.title event" do
      @event.update_review!(@review)
      expect(@event.action).to eq("更新了关于#{@review.todo.title}任务的评论！")
    end
    it "should be update review.title event" do
      @event.destroy_review!(@review)
      expect(@event.action).to eq("删除了关于#{@review.todo.title}任务的评论！")
    end
  end

  context "project" do
    it "should be create project.title event" do
      @event.create_project!(@project)
      expect(@event.action).to eq("创建了#{@project.title}项目！")
    end
  end
end
