require 'spec_helper'
# require File.expand_path('../../config/environment', __FILE__)
require_relative '../../app/services/nation_builder_service'

describe "Nation Builder Service", :vcr  do

  def nation_builder_connection
    NationBuilder::Service.new(
      nation_token: ENV.fetch("TEST_USER_TOKEN"),
      app_secret:   ENV.fetch('NATION_SECRET'),
      app_id:       ENV.fetch('NATION_APPID')
    )
  end

  params = {"utf8"=>"✓",
      "authenticity_token"=>"paReRRdPi60hWETewYU4QLNivA3RPfo2NmBciCqmWNaBU+8ku64vS+oIRKtsrPuPYiZltAIOdzUgMO56KhYjEw==",
      "event"=> {"name"=>"Test event",
                  "start_time"=>"09/04/2015 12:50 PM",
                  "end_time"=>"09/04/2015 12:55 PM",
                  "contact_attributes"=>{"name"=>"Test contact",
                                         "phone"=>"81855555555",
                                         "email"=>"test@example.com"},
      "status"=>"unlisted"},
      "commit"=>"Create Event",
      "controller"=>"events",
      "action"=>"create"}

  context "events for a given user" do
    it "all" do
      VCR.use_cassette('events') do
        expect((nation_builder_connection.events)["results"].count).to eq 6
      end
    end

    it "one" do
      VCR.use_cassette('event') do
        expect(nation_builder_connection.event("63")["event"]["id"]).to eq 63
      end
    end

    it "create" do
      VCR.use_cassette('create_event') do
        expect(nation_builder_connection.event_create(params)["event"]["name"]).to eq "Test event"
      end
    end

    xit "update" do
      VCR.use_cassette('create_event_for_update') do
        nation_builder_connection.event_create(params)
      end
      VCR.use_cassette('update_event_cassette') do
        nation_builder_connection.event_create(params)
        params = params
        params["event"]["name"] = "Test event update"
        expect(nation_builder_connection.event_update(params)["event"]["name"]).to eq "Test eventupdated"
      end
    end
  end
end
