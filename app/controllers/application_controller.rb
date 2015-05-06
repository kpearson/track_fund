class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :nbuilder, :nation_token

  private

  def nbuilder
    @nbuilder ||= NationBuilderService.new(
      page:       params[:next_page],
      nation_token: nation_token,
      app_secret: ENV.fetch('NATION_SECRET'),
      app_id:     ENV.fetch('NATION_APPID'),
    )
  end

  def nation_token
    token_object = current_user.tokens.find_by(provider: "nation_builder") if current_user
    token_object.token if token_object
  end

  def current_user
    @current_uesr = User.find(session[:user_id]) if session[:user_id]
  end

  def nation_url
    "https://trackfund.nationbuilder.com"
  end
end
