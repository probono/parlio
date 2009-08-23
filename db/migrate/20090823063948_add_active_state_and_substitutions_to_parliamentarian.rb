class AddActiveStateAndSubstitutionsToParliamentarian < ActiveRecord::Migration
  def self.up
    add_column :parliamentarians, :active, :boolean, :default => false
    add_column :parliamentarians, :substitution_id, :integer
  end

  def self.down
    remove_column :parliamentarians, :active
    remove_column :parliamentarians, :substitution_id
  end
end
