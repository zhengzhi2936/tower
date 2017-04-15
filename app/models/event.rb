# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  action     :string
#  user_id    :integer
#  team_id    :integer
#  project_id :integer
#  todo_id    :integer
#  review_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string
#  eventable  :string
#
# Indexes
#
#  index_events_on_project_id  (project_id)
#  index_events_on_review_id   (review_id)
#  index_events_on_team_id     (team_id)
#  index_events_on_todo_id     (todo_id)
#  index_events_on_user_id     (user_id)
#

class Event < ApplicationRecord
  belongs_to :team, :optional => true
  belongs_to :project, :optional => true
  belongs_to :todo, :optional => true
  belongs_to :review, :optional => true
  belongs_to :user, :optional => true

  def create_event!(todo)
    self.action = "建立了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.todo = todo
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end
  def update_event!(todo)
    self.action = "更新了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.todo = todo
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end
  # def destroy_event!(todo)
  #   self.action = "删除了#{todo.title}任务！"
  #   self.content = todo.title
  #   self.eventable = "todo"
  #   self.user = todo.user
  #   self.todo = todo
  #   self.project = todo.project
  #   self.team = todo.team
  #   self.save!
  # end

  def receive_event!(todo)
    self.action = "接受了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.user = todo.user
    self.todo = todo
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end

  def finish_event!(todo)
    self.action = "完成了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.todo = todo
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end

  def reopen_event!(todo)
    self.action = "取消领取了#{todo.title}任务！"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end

  def cancel_event!(todo)
    self.action = "取消了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.user = todo.user
    self.todo = todo
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end

  def renew_event!(todo)
    self.action = "恢复了#{todo.title}任务！"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end
  def assign_origin_executor_event!(todo)
    self.action = "指派了#{todo.title}任务给#{todo.assignment.origin_executor.email},完成时间#{todo.assignment.origin_deadline.strftime("%Y年%-m月%d日")}"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end
  def assign_new_executor_event!(todo)
    self.action = "重新指派了#{todo.title}给#{todo.assignment.new_executor.email},完成时间#{todo.assignment.new_deadline.strftime("%Y年%-m月%d日")}"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.project.team
    self.save!
  end

    def create_review!(review)
      self.action = "评论了#{review.todo.title}任务！"
      self.content = review.todo.title
      self.eventable = "review"
      self.review = review
      self.todo = review.todo
      self.user = review.user
      self.project = review.todo.project
      self.team = review.todo.project.team
      self.save!
    end
    def update_review!(review)
      self.action = "更新了关于#{review.todo.title}任务的评论！"
      self.content = review.todo.title
      self.eventable = "review"
      self.review = review
      self.todo = review.todo
      self.project = review.todo.project
      self.team = review.todo.project.team
      self.user = review.user
      self.save!
    end
    # def destroy_review!(review)
    #   self.action = "删除了关于#{review.todo.title}任务的评论！"
    #   self.content = review.todo.title
    #   self.eventable = "review"
    #   self.review = review
    #   self.project = review.project
    #   self.team = review.team
    #   self.user = review.user
    #   self.save!
    # end


    def create_project!(project)
      self.action = "创建了#{project.title}项目！"
      self.content = project.title
      self.team = project.team
      self.eventable = "project"
      self.project= project
      self.user = project.user
      self.save!
    end
end
