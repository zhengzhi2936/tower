class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project
  before_action :find_todo, except: [:new, :create]
  before_action :find_assignment, :only => [:show, :edit]
  def show
    @reviews = @todo.reviews
  end

  def new
    @todo = Todo.new
    @assignment = Assignment.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    if @todo.save
      @todo.aasm_state = "todo_created"
      @event.create_event!(@todo)
      assignment_params
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event = Event.new
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    assignment_params
    if @todo.update(todo_params)
      @event.update_event!(@todo)
    else
      render :edit
    end
  end

  def destroy
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.destroy
    # @event.destroy_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def receive_todo
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.receive_todo!
    @event.receive_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def finish_todo
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.finish_todo!
    @event.finish_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def reopen_todo
    @todo.user = current_user
    @todo.project = @project
    @todo.team = @team
    @event = Event.new
    @todo.reopen_todo!
    @event.reopen_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def cancel_todo
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.cancel_todo!
    @event.cancel_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def assign_people
    @todo.user = current_user
    @todo.project = @project
    @todo.team = @team
    @event = Event.new
    if @todo.update(todo_params)
      @event.assign_people_event!(@todo)
      redirect_to :back
    end
  end

  def assign_time
    @todo.user = current_user
    @todo.project = @project
    @todo.team = @team
    @event = Event.new
    if @todo.update(todo_params)
      @event.assign_time_event! (@todo)
      redirect_to :back
    end
  end
  def renew_todo
    @todo.user = current_user
    @todo.project = @project
    @todo.team = @team
    @event = Event.new
    @todo.renew_todo!
    @event.cancel_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  protected
  def find_assignment
  @assignment = @todo.assignment
  if @assignment.blank?
    @assignment = Assignment.new
  else
    if @assignment.origin_executor.present?
      @assignment.origin_executor_email = @assignment.origin_executor.email
    end
    if @assignment.new_executor.present?
      @assignment.new_executor_email = @assignment.new_executor.email
    end
  end
end
def assignment_params
  new_params = {}
  assignment = params[:todo][:assignment]
  origin_executor_email = assignment[:origin_executor_email]
  new_executor_email = assignment[:new_executor_email]
  origin_deadline = assignment[:origin_deadline]
  new_deadline = assignment[:new_deadline]
    @event = Event.new
  if origin_executor_email.present?
    @origin_executor = User.find_by_email(origin_executor_email)
    if !@origin_executor.present?
      @assignment = Assignment.new
      flash[:alert] = "无此用户"
      redirect_back(fallback_location: root_path)
      return
    end
    new_params[:origin_executor_id] = @origin_executor.id
  else
    new_params[:origin_executor_id] = nil
  end
  if new_executor_email.present?
    @new_executor = User.find_by_email(new_executor_email)
    if !@new_executor.present?
      @assignment = Assignment.new
      flash[:alert] = "无此用户"
      redirect_back(fallback_location: root_path)
      return
    end
    new_params[:new_executor_id] = @new_executor.id
  else
    new_params[:new_executor_id] = nil
  end

  if origin_deadline.present?
    new_params[:origin_deadline] = origin_deadline
  end

  if new_deadline.present?
    new_params[:new_deadline] = new_deadline
  end
  @assignment = @todo.assignment
  if @assignment.present?
    if @assignment.update(new_params)
      if new_params[:origin_executor_id].present? or new_params[:new_executor_id].present?
      @event.assign_people_event!(@todo)
      end
      flash[:notice] = "任务更新成功"
      redirect_to team_project_path(@team, @project)
    else
      render :edit
    end
  else
    if @todo.create_assignment(new_params)
      if new_params[:origin_executor_id].present?

        @event.assign_people_event!(@todo)
      end
      redirect_to team_project_path(@team, @project)
    else
      render :new
      flash[:notice] = "出现错误"
    end
  end
end
private

   def todo_params
     params.require(:todo).permit(:title, :description, :recipient, :deadline)
   end

   def find_team_and_project
     @team = Team.find(params[:team_id])
     @project = Project.find(params[:project_id])
   end

   def find_todo
    @todo = Todo.find(params[:id])
   end
end
