class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :nbuilder, :nation_token

  private

  def nbuilder
    current_user.nbuilder if current_user
  end

  def nation_token
    current_user.nation_token if current_user
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def nation_url
    "https://trackfund.nationbuilder.com"
  end
end
