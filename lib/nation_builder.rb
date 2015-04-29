require "ostruct"

class NationBuilder
  class People
    attr_accessor :next, :back, :people
    def initialize(attributes)
      self.next   = attributes.fetch :next
      self.back   = attributes.fetch :back
      self.people = attributes.fetch :people
    end

    include Enumerable
    def each(&block)
      return to_enum :each unless block
      people.each(&block)
    end
  end

  attr_accessor :page, :nation_url, :user_token, :app_id, :app_secret

  def initialize(attributes)
    self.page       = attributes[:page] || "/api/v1/people"
    self.nation_url = attributes.fetch :nation_url, "https://trackfund.nationbuilder.com"
    self.user_token = attributes[:user_token]
    self.app_id     = attributes.fetch :app_id
    self.app_secret = attributes.fetch :app_secret
  end

  def people
    conn = Faraday.new(nation_url)
    conn.params = { "access_token" => user_token }
    json = JSON.parse(conn.get(page).body)
    People.new(
      next:   json['next'],
      back:   json['back'],
      people: json['results'].map { |person| OpenStruct.new person }, # <-- idk
    )
  end

  def auth_request
    nation_auth_url = "/oauth/authorize?"
    response_type   = "response_type=code&"
    client_id       = "client_id=#{app_id}&"
    redirect_uri    = "redirect_uri=#{ENV["CALLBACK_URL"]}//auth/nationbuilder/callback"
    nation_url + nation_auth_url + response_type + client_id + redirect_uri
  end

  def token_request(code)
    conn = Faraday.new(nation_url)
    conn.params = { "client_id"     => app_id,
                    "redirect_uri"  => "#{ENV["CALLBACK_URL"]}/auth/nationbuilder/callback",
                    "grant_type"    => "authorization_code",
                    "client_secret" => app_secret,
                    "code"          => code
                  }
    body = conn.post("/oauth/token").body
    JSON.parse(body)["access_token"]
  end
end
