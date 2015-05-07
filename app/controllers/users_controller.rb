class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def add_user_token
    remove_nation_token
    current_user.tokens.create(token:   nbuilder.token_request(params.fetch :code),
                               provider: "nation_builder")
    redirect_to dashboard_path
  end

  def sign_out_nation
    remove_nation_token
    redirect_to dashboard_path
  end

  private

  def remove_nation_token
    token = current_user.tokens.find_by(provider: "nation_builder") if current_user
    token.destroy if token         #TODO: Look for a better way
  end
end
