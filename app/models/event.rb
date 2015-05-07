class Event < OpenStruct
  # def self.service
  #   @service ||= NationBuilderService.new
  # end

  def self.all(nbuilder)
    nbuilder.events["results"].map { |event| new(event) }
  end

  def self.find(id, nbuilder)
    new(nbuilder.event(id)["event"])
  end

  def self.create(params, nbuilder)
    new(nbuilder.event_create(params))
  end

  def self.all_rsvps(rsvps, nbuilder)
    rsvps.map { |rsvp| new(nbuilder.person(rsvp.id)) }
  end
end
