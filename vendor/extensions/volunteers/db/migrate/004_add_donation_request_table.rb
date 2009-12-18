class AddDonationRequestTable < ActiveRecord::Migration
  def self.up
    create_table :donation_requests do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :quantity, :integer
    end
  end

  def self.down
    drop_table :donation_requests
  end
end
