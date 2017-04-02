class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.teams.all
  end

  def show
    @team = Team.find(params[:id])
    @projects = @team.projects
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to "/"
    else
      render :new
    end
  end

private

  def team_params
    params.require(:team).permit(:name)
  end
end
