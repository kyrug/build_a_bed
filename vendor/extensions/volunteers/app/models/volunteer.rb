class Volunteer < ActiveRecord::Base
  belongs_to :job
  
  #run some cleanup methods
  before_save :capitalize_names
  before_update :capitalize_names
  
  #validating name
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  
  #validating email
  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email, :on => :create, :message => "already submitted; must be unique"
  
  #validating phone
  validates_format_of :phone, :on => :create, :with => /^[+\/\-() 0-9]+$/, :message => 'is an invalid phone number, only the following characters are allowed: 0-9/-()+'
  
  private
    def capitalize_names
      self.firstname.capitalize!
      if self.lastname.include? "-"
        pieces_array = self.lastname.split("-")
        pieces_array.each { |e| e.capitalize! }
        joined = pieces_array.join("-")
        self.lastname = joined
      else
        self.lastname.capitalize!
      end
    end
end
