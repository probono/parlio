class AddOrigIdToParliamentarian < ActiveRecord::Migration
  def self.up
    add_column :parliamentarians, :orig_id, :string
  end

  def self.down
    remove_column :parliamentarians, :orig_id
  end
end
