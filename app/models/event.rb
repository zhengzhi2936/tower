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
    self.team = todo.team
    self.save!
  end
  def update_event!(todo)
    self.action = "更新了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.todo = todo
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
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
    self.team = todo.team
    self.save!
  end

  def finish_event!(todo)
    self.action = "完成了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.todo = todo
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
    self.save!
  end

  def reopen_event!(todo)
    self.action = "取消领取了#{todo.title}任务！"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
    self.save!
  end

  def cancel_event!(todo)
    self.action = "取消了#{todo.title}任务！"
    self.content = todo.title
    self.eventable = "todo"
    self.user = todo.user
    self.todo = todo
    self.project = todo.project
    self.team = todo.team
    self.save!
  end

  def renew_event!(todo)
    self.action = "恢复了#{todo.title}任务！"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
    self.save!
  end
  def assign_people_event!(todo)
    self.action = "指派了#{todo.title}任务给#{todo.recipient}"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
    self.save!
  end
  def assign_time_event!(todo)
    self.action = "指派了#{todo.title}任务最后完成日期#{todo.deadline}"
    self.content = todo.title
    self.todo = todo
    self.eventable = "todo"
    self.user = todo.user
    self.project = todo.project
    self.team = todo.team
    self.save!
  end

    def create_review!(review)
      self.action = "评论了#{review.todo.title}任务！"
      self.content = review.todo.title
      self.eventable = "review"
      self.review = review
      self.user = review.user
      self.project = review.project
      self.team = review.team
      self.save!
    end
    def update_review!(review)
      self.action = "更新了关于#{review.todo.title}任务的评论！"
      self.content = review.todo.title
      self.eventable = "review"
      self.review = review
      self.project = review.project
      self.team = review.team
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
