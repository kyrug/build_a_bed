module BedRequestProcess
  def self.included kls
    kls.send :alias_method_chain, :process, :bed_request
    kls.class_eval { attr_accessor :last_bed_request }
  end

  def process_with_bed_request request, response
    if request.post? and request.parameters[:bed_request]
      bed_request = BedRequest.new(request.parameters[:bed_request])
      bed_request.save
      self.last_bed_request = bed_request
    end
    process_without_bed_request request, response
  end
end
