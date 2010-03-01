class AddBedRequests < ActiveRecord::Migration
  def self.up
    create_table :bed_requests do |t|
      t.column :recipient_first_name, :string
      t.column :recipient_middle_name, :string
      t.column :recipient_last_name, :string
      t.column :recipient_dob, :string
      t.column :recipient_address, :string
      t.column :recipient_city, :string
      t.column :recipient_zip, :string
      t.column :recipient_county, :string
      t.column :recipient_school_district, :string
      t.column :recipient_parent_first_name, :string
      t.column :recipient_parent_last_name, :string
      t.column :recipient_phone, :string
      
      t.column :referral_first_name, :string
      t.column :referral_middle_name, :string
      t.column :referral_last_name, :string
      t.column :referral_title, :string
      t.column :referral_organization, :string
      t.column :referral_address, :string
      t.column :referral_city, :string
      t.column :referral_zip, :string
      t.column :referral_county, :string
      t.column :referral_phone, :string
      t.column :referral_email, :string
      t.column :referral_relationship, :string
      
      t.column :comments, :text
    end
  end

  def self.down
    drop_table :bed_requests
  end
end
