class AddTopicToInitiative < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :topic_id, :integer
  end

  def self.down
    remove_column :initiatives, :topic_id
  end
end
