class AddJobTable < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.column :name, :string
      t.column :quantity, :integer
    end
  end

  def self.down
    drop_table :jobs
  end
end
