class CreateInterventionSpeakers < ActiveRecord::Migration
  def self.up
    create_table :intervention_speakers do |t|
      t.integer :intervention_id
      t.integer :speaker_id

      t.timestamps
    end
  end

  def self.down
    drop_table :intervention_speakers
  end
end
