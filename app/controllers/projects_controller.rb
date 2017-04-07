class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:new, :create, :show, :edit, :update, :destroy]
    before_action :find_project, only: [:edit, :destroy]
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.team = @team
    @project.user = current_user
    @event = Event.new
    if @project.save
       @event.create_project!(@project)
      redirect_to team_path(@team)
    else
      render :new
    end
  end
  def show
    @project = @team.projects.find(params[:id])
    @todos = @project.todos
  end

  def edit

  end

  def update
    @project = Project.new(project_params)
    @project.team = @team
    @project.user = current_user
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to team_path(@team)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.team = @team
    @project.destroy
    redirect_to team_path(@team)
  end

private

  def project_params
    params.require(:project).permit(:title)
  end

  def find_team
    @team = Team.find(params[:team_id])
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
