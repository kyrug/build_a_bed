class AddDonationTable < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :phone, :string
      t.column :email, :string
      t.column :donation_request_id, :integer
      t.column :quantity, :integer
    end
  end

  def self.down
    drop_table :donations
  end
end
