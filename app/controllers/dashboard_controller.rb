class DashboardController < ApplicationController
  require "ostruct"

  def index
    if params[:next_page]
      people = index_people(params[:next_page]) if user_token
    else
      people = index_people if user_token
    end
    @page_next  = people["next"]
    @page_back  = people["back"]
    @people     = people["results"].map { |person| OpenStruct.new(person) }
    @nation_url = nation_url + "/api/v1/people"
  end

  def new
    redirect_to nation_auth_request
  end

  def add_user_token
    remove_nation_token
    current_user.tokens.create(token: nation_token_request,
                               provider: "nation_builder")
    redirect_to dashboard_path
  end

  def sign_out_nation
    remove_nation_token
    redirect_to root_path
  end

  def remove_nation_token
    token = current_user.tokens.find_by(provider: "nation_builder") if current_user
    token.destroy if token
  end

  private

  def index_people(page = "/api/v1/people")
    conn = Faraday.new(nation_url)
    conn.params = { "access_token" => user_token }
    JSON.parse(conn.get(page).body)
  end

  def nation_auth_request
    nation_auth_url = "/oauth/authorize?"
    response_type   = "response_type=code&"
    client_id       = "client_id=#{ENV["NATION_APPID"]}&"
    redirect_uri    = "redirect_uri=http://localhost:3000/auth/nationbuilder/callback"
    nation_url + nation_auth_url + response_type + client_id + redirect_uri
  end

  def nation_token_request
    conn = Faraday.new(nation_url)
    conn.params = { "client_id"     => ENV["NATION_APPID"],
                    "redirect_uri"  => "http://localhost:3000/auth/nationbuilder/callback",
                    "grant_type"    => "authorization_code",
                    "client_secret" => ENV["NATION_SECRET"],
                    "code"          => params[:code]
                  }
    JSON.parse(conn.post("/oauth/token").body)["access_token"]
  end

  def next_page(result)
    nation_url + index_people["next"] + "access_token => #{token}"
    # conn = Faraday.new(nation_url)
    # conn.params = { "access_token" => user_token.token }
    # JSON.parse(conn.get("/api/v1/people").body)
  end

  def user_token
    current_user.tokens.find_by(provider: "nation_builder").token if current_user
  end

  def nation_url
    "https://trackfund.nationbuilder.com"
  end
end
