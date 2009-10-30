class Job < ActiveRecord::Base
  has_many :volunteers
  
  # validates presence of name
  validates_presence_of :name, :message => "can't be blank"

  # validates the quantity greater than 0
  validates_numericality_of :quatity, :only_integer => :true
  validates_numericality_of :quatity, :greater_than_or_equal_to => 0, :message => "must be greater than or equal to 0"
end

