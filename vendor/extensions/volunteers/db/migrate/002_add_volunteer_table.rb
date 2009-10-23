class AddVolunteerTable < ActiveRecord::Migration
  def self.up
    create_table :volunteers do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :phone, :string
      t.column :email, :string
      t.column :job_id, :integer
    end
  end

  def self.down
    drop_table :volunteers
  end
end
