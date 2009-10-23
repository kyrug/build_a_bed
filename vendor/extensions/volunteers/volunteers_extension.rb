# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class VolunteersExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/volunteers"
  
  #define_routes do |map|
  #  map.namespace :admin, :member => { :remove => :get } do |admin|
  #    admin.resources :volunteers
  #  end
  #end
  define_routes do |map|
    map.resources :jobs, :path_prefix => '/admin'
  end
  
  def activate
    admin.tabs.add "Volunteers", "/admin/volunteers", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Jobs", "/admin/jobs", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Volunteers"
  end
  
end
