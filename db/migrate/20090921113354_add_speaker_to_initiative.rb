class AddSpeakerToInitiative < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :speaker_id, :integer
  end

  def self.down
    remove_column :initiatives, :speaker_id
  end
end
