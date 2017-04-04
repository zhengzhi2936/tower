class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:team_id])
    @todo = Todo.find(params[:todo_id])
    @review = Review.new
  end

  def create
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:team_id])
    @todo = Todo.find(params[:todo_id])
    @review = Review.new(review_params)
    @event = Event.new
    @review.todo = @todo
    @review.user = current_user
    if @review.save!
      @event.create_review!(@review)
      redirect_to team_project_todo_path(@team, @project, @todo)
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:team_id])
    @todo = Todo.find(params[:todo_id])
    @review = Review.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:team_id])
    @todo = Todo.find(params[:todo_id])
    @review = Review.find(params[:id])
    @event = Event.new
    @review.todo = @todo
    @review.user = current_user
    if @review.update(review_params)
      @event.update_review!(@review)
      redirect_to team_project_todo_path(@team, @project, @todo)
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:team_id])
    @todo = Todo.find(params[:todo_id])
    @review = Review.find(params[:id])
    @event = Event.new
    @review.destroy
    @event.destroy_review!(@review)
      redirect_to team_project_todo_path(@team, @project, @todo)
  end

private

  def review_params
    params.require(:review).permit(:content)
  end
end
