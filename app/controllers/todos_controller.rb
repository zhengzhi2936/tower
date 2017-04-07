class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project
  before_action :find_todo, except: [:new, :create]
  def show
    @reviews = @todo.reviews
  end

  def new
    @todo = Todo.new
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
      redirect_to team_project_path(@team, @project)
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
    if @todo.update(todo_params)
      @event.update_event!(@todo)
      redirect_to team_project_path(@team, @project)
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
