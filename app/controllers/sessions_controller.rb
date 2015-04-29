class SessionsController < ApplicationController

  def new
    redirect_to facebook_login_request
  end

  def create
    @user = User.find_or_create_from_auth(facebook_user)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def destroy
    user_name = current_user.first_name
    session[:user_id] = nil
    redirect_to root_path, notice: "Good bye #{user_name}. You are loged out."
  end

  private

#TODO: Hoist below into a module
  def facebook_user
    conn = Faraday.new(facebook_graph_url)
    user_token = facebook_auth["access_token"]
    conn.params = { "access_token" => user_token,
                    "client_id" => "#{ENV["FACEBOOK_APPID"]}|#{ENV["FACEBOOK_SECRET"]}"
                  }
    user = JSON.parse(conn.get("me").body)
    user["token"]    = user_token
    user["provider"] = "facebook"
    user
  end

  def facebook_login_request
    url            = "dialog/oauth"
    client_id      = "?client_id=#{ENV["FACEBOOK_APPID"]}&"
    redirect_uri   = "redirect_uri=#{ENV["CALLBACK_URL"]}/auth/facebook/callback"
   "https://facebook.com/" + url + client_id + redirect_uri
  end

  def facebook_auth
    conn = Faraday.new(facebook_graph_url)
    conn.params = { "client_id" => ENV["FACEBOOK_APPID"],
                    "client_secret" => ENV["FACEBOOK_SECRET"],
                    "redirect_uri" => "#{ENV["CALLBACK_URL"]}/auth/facebook/callback",
                    "code" => params["code"]
                  }
    JSON.parse(conn.get("v2.3/oauth/access_token").body)
  end

  def facebook_graph_url
    "https://graph.facebook.com/"
  end
end
