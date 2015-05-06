class EventsController < ApplicationController
  def index
    # @events = Event.all(nbuilder) if nation_token
    @events = []
  end

  def new
    # @event   = Event.new
    # @people  = nbuilder.people if nation_token
    # @pledge = Pledge.new
  end

  def show
    @event     = Event.find(params[:id], nbuilder)
    @pledges   = Pledge.where(nbuilder_event_id: params[:id])
    @people    = nbuilder.people if nation_token
    @page_next = @people.next    if nation_token
    @page_back = @people.back    if nation_token
  end

  def create
    event = Event.create(params, nbuilder)
    binding.pry
    if event.code == "validation_faild"
      render new, flash[:warning] = "#{event.validation_errors.first}"
    else
      redirect_to event_path(event.event["id"])
    end
  end

  def edit
    @pledge = Pledge.new
    @event  = Event.find(params[:id], nbuilder)
    @people = nbuilder.people if nation_token
  end

  def update
  end

  def destroy
  end
end
