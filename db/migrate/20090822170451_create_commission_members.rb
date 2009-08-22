class CreateCommissionMembers < ActiveRecord::Migration
  def self.up
    create_table :commission_members do |t|
      t.integer :commision_id
      t.integer :parliamentarian_id
      t.string :position
      t.string :date

      t.timestamps
    end
  end

  def self.down
    drop_table :commission_members
  end
end
