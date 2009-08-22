class AddStatusToInitiative < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :status, :string
  end

  def self.down
    remove_column :initiatives, :status
  end
end
