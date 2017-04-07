class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find(params[:team_id])
    @events = @team.events.all.order("id DESC")
    @group_events = @events.group("strftime('%Y-%m-%d', @events.created_at)")
  end
end
