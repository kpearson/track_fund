require 'nation_builder'

class DashboardController < ApplicationController
  def index
    @people     = nbuilder.people if nation_token # <-- btw, prob proken (undefined method [] on nil:NilClass)
    @page_next  = @people.next if nation_token
    @page_back  = @people.back if nation_token
    @event      = nbuilder.events if nation_token
  end

  def show
    @people     = nbuilder.people if nationuser_token # <-- btw, prob proken (undefined method [] on nil:NilClass)
    @page_next  = @people.next if nation_token
    @page_back  = @people.back if nation_token
  end
end
