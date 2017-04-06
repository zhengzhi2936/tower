class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find(params[:team_id])
    @events = @team.events.all
    @group_events = @events.group_by{|e| e.created_at.to_date}
  end
end
