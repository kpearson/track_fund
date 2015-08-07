require 'active_resource'

class Event < ActiveResource::Base
  self.site = "https://trackfund.nationbuilder.com"

  def contact_attributes=(attributes)
  end

  def persisted=(arg)
    @persisted = arg
  end

  def self.all(nbuilder)
    nbuilder.events["results"].map { |event| new(event) }
  end

  def self.find(id, nbuilder)
    new(nbuilder.event(id)["event"])
  end

  def self.create(params, nbuilder)
    new(nbuilder.event_create(params))
  end

  def self.update(params, nbuilder)
    new(nbuilder.event_update(params))
  end

  def self.all_rsvps(rsvps, nbuilder)
    rsvps.map { |rsvp| new(nbuilder.person(rsvp.id)) }
  end

  def self.destroy(params, nbuilder)
    nbuilder.event_destroy(params)
  end

  def self.publish(params, nbuilder)
    nbuilder.event_publish(params)
  end
end
