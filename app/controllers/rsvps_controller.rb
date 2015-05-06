class RsvpsController < ApplicationController

  def create
    Rsvp.create(params, nbuilder)
    redirect_to :back
  end
end
