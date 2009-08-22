class RemoveTagsFromInitiatives < ActiveRecord::Migration
  def self.up
    remove_column :initiatives, :tags
  end

  def self.down
    add_column :initiatives, :tags, :string
  end
  
end
