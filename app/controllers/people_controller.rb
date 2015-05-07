class PeopleController < ApplicationController
  # require "ostruct"

  def show
    @person = OpenStruct.new(show_person["person"])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    People.update(params, nbuilder)
    redirect_to :back
  end

  def destroy
  end

  def show_person
    connection.params = { "access_token" => user_token }
    JSON.parse(conn.get("/api/v1/people/#{params[:id]}").body)
  end

  private

  def connection
    @connection ||= Faraday.new(nation_url)
  end

  def user_token
    current_user.tokens.find_by(provider: "nation_builder").token
  end
end
