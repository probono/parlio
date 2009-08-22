class CreateParties < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|
      t.string :group_name
      t.string :acronym
      t.string :sites
      t.string :name
      t.string :url
      t.string :logo

      t.timestamps
    end
  end

  def self.down
    drop_table :parties
  end
end
