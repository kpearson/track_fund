class PeopleController < ApplicationController
  require "ostruct"

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
  end

  def destroy
  end

  def show_person
    conn = Faraday.new(nation_url)
    conn.params = { "access_token" => user_token }
    JSON.parse(conn.get("/api/v1/people/#{params[:id]}").body)
  end

  private

  def user_token
    current_user.tokens.find_by(provider: "nation_builder").token
  end

  def nation_url
    "https://trackfund.nationbuilder.com"
  end
end
