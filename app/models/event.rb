require 'active_resource'

class Event < ActiveResource::Base
  self.site = "https://trackfund.nationbuilder.com"

  has_many :contact

  # def contact
  #   @contact
  # end

  def contact_attributes=(attributes)
    {
      "name" => attribute[:name],
      "phone" => attributes[:phone],
      "email" => attributes[:email]
    }
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
end
