class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_team_permission, :except => [:index, :new, :create, :join]
  before_action :find_team, only: [:show, :edit, :update, :join, :quit, :destroy]
  def index
    @teams = Team.all
  end

  def show
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

  def edit
  end

  def update
    @team.user = current_user
    if @team.update(team_params)
      redirect_to "/"
    else
      render :edit
    end
  end
  def join
    if !current_user.has_permission_to_access_to_team?(@team)
      TeamPermission.create([user_id: current_user.id, team_id: @team.id, level: "member"])
    else
      flash[:warning] = "你已经是团队成员，如何加入"
    end
      redirect_to :back
  end

  def quit
    team_permissions = current_user.team_permissions.find_by_team_id(@team)
    if current_user.has_permission_to_access_to_team?(@team)
    team_permissions.delete
  else
    flash[:warning] = "请先加入团队"
    end
    redirect_to :back  
  end
  # def join
  #   if !current_user.is_member_of?(@team)
  #     current_user.join!(@team)
  #     flash[:notice] = "加入团队成功！"
  #   else
  #     flash[:warning] = "你已经是本团队成员了！"
  #   end
  #
  #   redirect_to :back
  # end
  #
  # def quit
  #   if current_user.is_member_of?(@team)
  #     current_user.quit!(@team)
  #     flash[:alert] = "已退出本团队！"
  #   else
  #     flash[:warning] = "你不是本团队成员，怎么退出 XD"
  #   end
  #
  #   redirect_to :back
  # end



  def destroy
   @team.destroy
   redirect_to "/"
  end
private

  def check_team_permission
    unless current_user.has_permission_to_access_to_team?(params[:id])
      flash[:alert] = "等等，你好像不是我们机组的"
      redirect_to "/"
    end
  end


  def team_params
    params.require(:team).permit(:name)
  end

  #
  # def require_is_admin_of_team
  #   @team = Team.all.find(params[:id])
  #   if !current_user.is_owner_of?(@team)
  #     redirect_to "/", alert: "你不管理员"
  #   end
  # end

  def find_team
    @team = Team.find(params[:id])
  end
end
