class EventsController < ApplicationController
  def index
    @events = Event.all(nbuilder) if nation_token
  end

  def show
    @event     = Event.find(params[:id], nbuilder)
    @pledges   = Pledge.where(nbuilder_event_id: params[:id])
    @people    = nbuilder.people if nation_token
    @page_next = @people.next    if nation_token
    @page_back = @people.back    if nation_token
  end

  def new
    @event = Event.new("name" => nil, "start_time" => nil, "end_time" => nil)
  end

  def create
    event = Event.create(params, nbuilder)
    if event.code && event.code == "validation_failed"
      flash[:warning] = "#{event.validation_errors.first}"
      redirect_to :back
    else
      redirect_to event_path(event.event["id"])
    end
  end

  def edit
    @pledge = Pledge.new
    binding.pry
    @contact = Contact.new(name: params[:id].to_i)
    @event  = Event.find(params[:id], nbuilder)
    @event.persisted = true
    @people = nbuilder.people if nation_token
  end

  def update
    event = Event.update(params, nbuilder)
    # if event.code == "validation_failed" && event.code
    #   flash[:warning] = "#{event.validation_errors.first}"
    #   redirect_to :back
    # else
      redirect_to event_path(params[:id])
    # end
  end

  def destroy
  end

  def add_doners
    @people = nbuilder.people if nation_token
  end

end
