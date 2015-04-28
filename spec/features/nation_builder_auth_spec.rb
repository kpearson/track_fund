require "rails_helper"

describe "Nation Builder oauth" do
  xit "gets a user auth token" do
    user = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)
    visit "/dashboard"
    click_button "Access your nation"
    if page.has_content?("I have an account")
      fill_in "user_session_email", with: "kitpearson@me.com"
      fill_in "password", with: "password"
    else
    expect(page).to have_content("Create an Event")
    end
  end
end
