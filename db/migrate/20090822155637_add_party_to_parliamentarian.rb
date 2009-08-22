class AddPartyToParliamentarian < ActiveRecord::Migration
  def self.up
    add_column :parliamentarians, :party_id, :integer
  end

  def self.down
    remove_column :parliamentarians, :party_id
  end
end
