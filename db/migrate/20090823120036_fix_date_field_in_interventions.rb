class FixDateFieldInInterventions < ActiveRecord::Migration
  def self.up
    remove_column :interventions, :session_date
    add_column :interventions, :session_date, :date
  end

  def self.down
    remove_column :interventions, :session_date
    add_column :interventions, :session_date, :string
  end
end
