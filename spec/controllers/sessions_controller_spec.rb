require "rails_helper"

RSpec.describe SessionsController, :omniauth do

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do

    xit "creates a user" do
      expect {post :create, provider: :facebook}.to change{ User.count }.by(1)
    end

  end
end
