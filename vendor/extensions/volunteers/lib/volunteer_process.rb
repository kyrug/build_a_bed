module VolunteerProcess
  def self.included kls
    kls.send :alias_method_chain, :process, :volunteer
    kls.class_eval { attr_accessor :last_volunteer }
  end

  def process_with_volunteer request, response
    if request.post? and request.parameters[:volunteer]
      volunteer = Volunteer.new(request.parameters[:volunteer])
      volunteer.save
      self.last_volunteer = volunteer
    end
    process_without_volunteer request, response
  end
end
