require 'nation_builder'

class DashboardController < ApplicationController
  def index
    @people     = nbuilder.people if user_token # <-- btw, prob proken (undefined method [] on nil:NilClass)
    @page_next  = @people.next if user_token
    @page_back  = @people.back if user_token
  end

  def new
    redirect_to nbuilder.auth_request
  end

  def add_user_token
    remove_nation_token
    current_user.tokens.create(token:   nbuilder.token_request(params.fetch :code),
                               provider: "nation_builder")
    redirect_to dashboard_path
  end

  def sign_out_nation
    remove_nation_token
    redirect_to root_path
  end

  private

  def user_token
    token_object = current_user.tokens.find_by(provider: "nation_builder")
    token_object.token if token_object
  end

  def remove_nation_token
    token = current_user.tokens.find_by(provider: "nation_builder") if current_user
    token.destroy if token         #TODO: Look for a better way
  end

  def nbuilder
    @nbuilder ||= NationBuilder.new(
      page:       params[:next_page],
      user_token: user_token,
      app_secret: ENV.fetch('NATION_SECRET'),
      app_id:     ENV.fetch('NATION_APPID'),
    )
  end
end
