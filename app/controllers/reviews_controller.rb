class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_project_todo
  before_action :find_review, only: [:edit, :update, :destroy]
  def new

    @review = Review.new
  end

  def create
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

  end

  def update
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
    @event = Event.new
    @review.destroy
    @event.destroy_review!(@review)
      redirect_to team_project_todo_path(@team, @project, @todo)
  end

private

  def review_params
    params.require(:review).permit(:content)
  end
  def find_team_project_todo
    @team = Team.find(params[:team_id])
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:todo_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
