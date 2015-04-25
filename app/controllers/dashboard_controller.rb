class DashboardController < ApplicationController
  def index
    @people = nation_people
  end

  def nation_people
   binding.pry
  end
end
