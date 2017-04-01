class ProjectsController < ApplicationController

  def index
    @project = Project.all
    flash[:notice] = "成功了"
  end
end
