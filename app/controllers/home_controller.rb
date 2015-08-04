class HomeController < ApplicationController
  skip_before_action :authorize, only: [:index, :login]

  def index
  end
end
