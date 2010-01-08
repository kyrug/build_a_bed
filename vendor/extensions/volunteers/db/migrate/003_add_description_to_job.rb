class AddDescriptionToJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :description, :text
  end

  def self.down
    remove_column :jobs, :description
  end
end
