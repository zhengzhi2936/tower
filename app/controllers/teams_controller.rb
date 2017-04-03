class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_member_of_team, except: [:index, :new, :create, :join]

  def index
    @teams = Team.all
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
    current_user.join!(@team)
      redirect_to "/"
    else
      render :new
    end
  end

  def join
   @team = Team.find(params[:id])

    if !current_user.is_member_of?(@team)
      current_user.join!(@team)
      flash[:notice] = "加入团队成功！"
    else
      flash[:warning] = "你已经是本团队成员了！"
    end

    redirect_to :back
  end

  def quit
    @team = Team.find(params[:id])

    if current_user.is_member_of?(@team)
      current_user.quit!(@team)
      flash[:alert] = "已退出本团队！"
    else
      flash[:warning] = "你不是本团队成员，怎么退出 XD"
    end

    redirect_to :back
  end
private

  def team_params
    params.require(:team).permit(:name)
  end

  def require_is_member_of_team
    @team = Team.all.find(params[:id])
    if !current_user.is_member_of?(@team)
      redirect_to "/", alert: "你不是团队成员"
    end
  end
end
