class ProjectsController < ApplicationController

  def new
    @team = Team.find(params[:team_id])
    @project = Project.new
  end

  def create
    @team = Team.find(params[:team_id])
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
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:id])
    @todos = @project.todos
  end

  def edit
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
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
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:id])
    @project.team = @team
    @project.destroy
    redirect_to team_path(@team)
  end

private

  def project_params
    params.require(:project).permit(:title)
  end
end
