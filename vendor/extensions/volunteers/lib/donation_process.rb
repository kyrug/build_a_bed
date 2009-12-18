module DonationProcess
  def self.included kls
    kls.send :alias_method_chain, :process, :donation
    kls.class_eval { attr_accessor :last_donation }
  end

  def process_with_donation request, response
    if request.post? and request.parameters[:donation]
      donation = Donation.new(request.parameters[:donation])
      donation.save
      self.last_donation = donation
    end
    process_without_donation request, response
  end
end
