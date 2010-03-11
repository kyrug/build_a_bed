class DonationRequest < ActiveRecord::Base
  has_many :donations
  
  # validates presence of name
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :description, :message => "can't be blank"

  # validates the quantity greater than 0
  validates_numericality_of :quantity, :only_integer => :true
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :message => "must be greater than or equal to 0"
  
  def filled?
    quantity_donated >= quantity
  end  


  def quantity_donated
    self.donations.inject(0) {|sum, d| sum + d.quantity }
  end
end

