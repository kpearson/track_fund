require "rails_helper"

describe "Create an event" do
  it "with no guests" do
    user = create :user
           create :token
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)
    visit "/dashboard"
    click_button "Create Event"
    fill_in "Event name", with: "new event"
    fill_in "Event discription", with: "event discription"
    fill_in "Venue name", with: "Ashings palace"
    expect(page).to have_content("new event")
  end
end
