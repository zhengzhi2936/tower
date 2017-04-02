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
    @todo.user = current_user
    if @todo.save
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
    @todo.project = @project
    @todo.user = current_user
    if @todo.update(todo_params)
      redirect_to team_project_path(@team, @project)
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.destroy
      redirect_to team_project_path(@team, @project)
  end

private

   def todo_params
     params.require(:todo).permit(:title, :description)
   end
end
