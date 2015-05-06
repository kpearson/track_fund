class NationBuilderService
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


  attr_accessor :page, :nation_url, :user_token, :app_id, :app_secret, :connection

  def initialize(attributes)
    self.nation_url = attributes.fetch :nation_url, "https://trackfund.nationbuilder.com"
    self.user_token = attributes[:nation_token]
    self.app_id     = attributes.fetch :app_id
    self.app_secret = attributes.fetch :app_secret
    @connection = Faraday.new(url: "https://trackfund.nationbuilder.com")
  end

  def people
    connection.params = { "access_token" => user_token }
    json = parse(connection.get("/api/v1/people"))
    People.new(
      next:   json['next'],
      back:   json['back'],
      people: json['results'].map { |person| OpenStruct.new person },
    )
  end

  def person(id)
    connection.params = { "access_token" => user_token }
    parse(connection.get("/api/v1/people/#{id}"))["person"]
  end

  def person_update(params)
    connection.params = { "access_token" => user_token }
    connection.put("/api/v1/people/#{params[:id]}")
  end

  def events
    connection.params = { "access_token" => user_token,
                          "site_slug" => "trackfund" }
    parse(connection.get("/api/v1/sites/trackfund/pages/events"))
  end

  def event(id)
    connection.params = { "access_token" => user_token }
    parse(connection.get("/api/v1/sites/trackfund/pages/events/#{id}"))
  end

  def event_create(params)
    connection.params = params
    connection.params["event"]["slug"] = params["event"]["name"].parameterize
    connection.params["access_token"] = user_token
    connection.headers['Content-Type'] = 'application/json'
    parse(connection.post("api/v1/sites/trackfund/pages/events"))
  end

  def rsvp_create(params)
    connection.params["access_token"] = user_token
    connection.params["rsvp"] = {"person_id" => params[:person_id]}
    connection.headers['Content-Type'] = 'application/json'
    connection.post("api/v1/sites/trackfund/pages/events/#{params[:event_id]}/rsvps")
  end

  def rsvps(params)
    connection.params["access_token"] = user_token
    parse(connection.get("/api/v1/sites/trackfund/pages/events/#{params}/rsvps"))
  end

  def auth_request
    nation_auth_url = "/oauth/authorize?"
    response_type   = "response_type=code&"
    client_id       = "client_id=#{app_id}&"
    redirect_uri    = "redirect_uri=#{ENV["CALLBACK_URL"]}/auth/nationbuilder/callback"
    nation_url + nation_auth_url + response_type + client_id + redirect_uri
  end

  def token_request(code)
    connection.params = { "client_id"     => app_id,
                          "redirect_uri"  => "#{ENV["CALLBACK_URL"]}/auth/nationbuilder/callback",
                          "grant_type"    => "authorization_code",
                          "client_secret" => app_secret,
                          "code"          => code
                        }
    parse(connection.post("/oauth/token"))["access_token"]
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
