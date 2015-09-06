class PledgesController < ApplicationController

  def new
    @people = nbuilder.people if nation_token
    @pledge = Pledge.new
  end

  def create
    pledge = Pledge.new(pledge_params)
    if pledge.save
      redirect_to :back
    else
      flash[:warning] = "Sorry: An amount must be entered"
      redirect_to :back
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:nbuilder_person_id,
                                   :nbuilder_event_id,
                                   :name,
                                   :fulfilled,
                                   :amount)
  end

end
