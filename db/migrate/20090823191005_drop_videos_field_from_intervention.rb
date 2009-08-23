class DropVideosFieldFromIntervention < ActiveRecord::Migration
  def self.up
    remove_column :interventions, :videos
  end

  def self.down
    add_column :interventions, :videos, :string
  end
end
