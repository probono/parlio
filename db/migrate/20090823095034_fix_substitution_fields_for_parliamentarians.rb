class FixSubstitutionFieldsForParliamentarians < ActiveRecord::Migration
  def self.up
    add_column :parliamentarians, :substitutes_id, :integer
    add_column :parliamentarians, :substituted_by_id, :integer
  end

  def self.down
    remove_column :parliamentarians, :substitutes_id
    remove_column :parliamentarians, :substituted_by_id
  end
end
