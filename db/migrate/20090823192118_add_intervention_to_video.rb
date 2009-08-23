class AddInterventionToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :intervention_id, :integer
  end

  def self.down
    remove_column :videos, :intervention_id
  end
end
