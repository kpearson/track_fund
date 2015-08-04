require 'active_resource'

class Contact < ActiveResource::Base
  self.site = "https://trackfund.nationbuilder.com"

  belongs_to :event

  def persisted=(arg)
    @persisted = arg
  end

end
