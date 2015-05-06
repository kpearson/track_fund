class People < OpenStruct

  def all_rsvps(rsvps, nbuilder)
    nbuilder.rsvps.id.map { |rsvp| new(rsvp) }
  end

  def self.update(params, nbuilder)
    nbuilder.person_update(params)
  end
end
