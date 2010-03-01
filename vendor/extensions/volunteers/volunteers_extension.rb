class VolunteersExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/volunteers"

  define_routes do |map|
    map.resources :jobs, :path_prefix => '/admin'
    map.resources :volunteers, :path_prefix => '/admin'
    map.resources :donation_requests, :path_prefix => '/admin'
    map.resources :donations, :path_prefix => '/admin'
    map.resources :bed_requests, :path_prefix => '/admin'
  end

  def activate
    Page.send :include, VolunteerTags
    Page.send :include, VolunteerProcess
    Page.send :include, DonationTags
    Page.send :include, DonationProcess
    Page.send :include, BedRequestTags
    Page.send :include, BedRequestProcess

    admin.tabs.add "Volunteers", "/admin/volunteers", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Jobs", "/admin/jobs", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Donations", "/admin/donations", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Donation Requests", "/admin/donation_requests", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Bed Requests", "/admin/bed_requests", :after => "Layouts", :visibility => [:all]
  end

  def deactivate
  end

end
