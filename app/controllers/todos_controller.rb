class TodosController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @reviews = @todo.reviews
  end

  def new
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.new
  end

  def create
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
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
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
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
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo.project = @project
    @todo.team = @team
    @todo = Todo.find(params[:id])
    @todo.user = current_user
    @event = Event.new
    @todo.destroy
    @event.destroy_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def receive_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.receive_todo!
    @event.receive_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def finish_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.finish_todo!
    @event.finish_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def reopen_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.user = current_user
    @todo.project = @project
    @todo.team = @team
    @event = Event.new
    @todo.reopen_todo!
    @event.reopen_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def cancel_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.project = @project
    @todo.team = @team
    @todo.user = current_user
    @event = Event.new
    @todo.cancel_todo!
    @event.cancel_event!(@todo)
      redirect_to team_project_path(@team, @project)
  end

  def renew_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
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
     params.require(:todo).permit(:title, :description)
   end
end
