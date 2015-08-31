class EventsController < ApplicationController
  def index
    @events = Event.all(current_user) if nation_token
  end

  def show
    @event     = Event.find(params[:id], nbuilder)
    @pledges   = Pledge.where(nbuilder_event_id: params[:id])
    @people    = nbuilder.people if nation_token
    @page_next = @people.next    if nation_token
    @page_back = @people.back    if nation_token
  end

  def new
    @event = Event.new("name"       => nil,
                       "start_time" => nil,
                       "end_time"   => nil,
                       "contact"    => { "name"  => nil,
                                         "phone" => nil,
                                         "email" => nil
                                       }
                      )
  end

  def create
    event = Event.create(params, nbuilder)
    redirect_to event_path(event.id)
  end

  def edit
    @pledge          = Pledge.new
    @event           = Event.find(params[:id], nbuilder)
    @event.persisted = true
    @people          = nbuilder.people if nation_token
  end

  def update
    Event.update(params, nbuilder)
    redirect_to event_path(params[:id])
  end

  def publish
    Event.find(params[:id], nbuilder)
    Event.publish(params, nbuilder)
    redirect_to :back
  end

  def destroy
    Event.destroy(params, nbuilder)
    redirect_to "events/index"
  end

  def add_doners
    @people = nbuilder.people if nation_token
  end

end
