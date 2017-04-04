class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
    @group_events = @events.group_by{|e| e.created_at.to_date}
  end
end
