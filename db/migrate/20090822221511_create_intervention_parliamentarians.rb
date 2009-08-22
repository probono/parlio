class CreateInterventionParliamentarians < ActiveRecord::Migration
  def self.up
    create_table :intervention_parliamentarians do |t|
      t.integer :intervention_id
      t.integer :parliamentarian_id

      t.timestamps
    end
  end

  def self.down
    drop_table :intervention_parliamentarians
  end
end
