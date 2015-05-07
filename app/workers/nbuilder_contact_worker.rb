class NbuilderContactWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    user = User.first
    nbuilder_people = user.nbuilder.all_people
    nbuilder_people.each do |nbuilder_person|
      contact = Contact.find_or_initialize_by(nbuilder_person_id: nbuilder_person.id)
      contact.name = nbuilder_person.first_name + " " + nbuilder_person.last_name
      contact.save!
      puts "Saved contact for #{contact.name}"
    end
    nil
  end

end
