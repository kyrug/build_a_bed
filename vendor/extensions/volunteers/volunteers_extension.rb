class VolunteersExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/volunteers"

  define_routes do |map|
    map.resources :jobs, :path_prefix => '/admin'
    map.resources :volunteers, :path_prefix => '/admin'
  end

  def activate
    Page.send :include, VolunteerTags
    Page.send :include, VolunteerProcess

    admin.tabs.add "Volunteers", "/admin/volunteers", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Jobs", "/admin/jobs", :after => "Layouts", :visibility => [:all]
  end

  def deactivate
  end

end
