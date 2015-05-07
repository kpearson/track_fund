require 'rails_helper'

RSpec.describe Pledge, type: :model do
  describe "Pledge" do
    it "has a user" do
      pledge = create(:pledge)
      expect(pledge.nbuilder_person_id).to eq 1
      expect(pledge.nbuilder_event_id).to eq 27
    end

    it "must have an amount" do
      expect(build(:pledge, amount: 0)).not_to be_valid
      expect(build(:pledge, amount: nil)).not_to be_valid
      expect(build(:pledge, amount: 1)).to be_valid
    end
  end
end
