class Rsvp < OpenStruct

  # def self.service
  #   @service ||= NationBuilderService.new
  # end

  def self.create(params, nbuilder)
    nbuilder.rsvp_create(params)
  end

  def self.all(id, nbuilder)
    nbuilder.rsvps(id)["results"].map { |rsvp| new(rsvp) }
  end
end
